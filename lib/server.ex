defmodule Hermit.Server do
  use GenServer
  alias Hermit.UpdatesServer
  alias Hermit.SenderServer

  def start_link(listening_period \\ 1000) do
    GenServer.start_link(__MODULE__, listening_period, name: __MODULE__)
  end

  def listen do
    GenServer.cast __MODULE__, {:listen}
  end

  def handle_cast({:listen}, listening_period) do
    updates = UpdatesServer.updates
    unless updates |> Enum.empty?, do: SenderServer.send_messages(updates)


    :timer.sleep(listening_period)
    listen
    {:noreply, listening_period}
  end

  def init(args) do
    listen
    {:ok, args}
  end
end
