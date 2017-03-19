defmodule Hermit.Communicator.Server do
  use GenServer
  alias Hermit.Consumers.ConsumerBase
  alias Hermit.Providers.ProviderBase

  def start_link(provider, consumer, listening_period \\ 1000) do
    GenServer.start_link(__MODULE__, {provider, consumer, listening_period}, name: __MODULE__)
  end

  def listen do
    GenServer.cast __MODULE__, {:listen}
  end

  def handle_cast({:listen}, {provider, consumer, listening_period}) do
    updates = ProviderBase.updates(provider)
    unless updates |> Enum.empty?, do: ConsumerBase.send_messages(consumer, updates)

    :timer.sleep(listening_period)
    listen
    {:noreply, {provider, consumer, listening_period}}
  end

  def init(args) do
    listen
    {:ok, args}
  end
end
