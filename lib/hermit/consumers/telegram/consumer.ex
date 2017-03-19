defmodule Hermit.Consumers.Telegram.Consumer do
  use GenServer
  alias Hermit.Consumers.Telegram.API

  def start_link(name, user_id) do
    GenServer.start_link(__MODULE__, {user_id}, name: name)
  end

  def stop(name) do
    GenServer.stop name
  end

  def send_message(name, message) do
    GenServer.cast name, {:send_message, message}
  end

  def send_messages(name, messages) do
    GenServer.cast name, {:send_messages,  messages}
  end

  def handle_cast({:send_message, message}, {user_id}) do
    {:ok, _} = API.send_message(user_id, message)

    {:noreply, {user_id}}
  end

  def handle_cast({:send_messages, messages}, {user_id}) do
    messages
    |> Enum.each(fn(message) ->
      {:ok, _} = API.send_message(user_id, message)
    end)

    {:noreply, {user_id}}
  end
end
