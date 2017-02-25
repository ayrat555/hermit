defmodule Hermit.SenderServer do
  use GenServer
  alias Hermit.Api.TelegramApi

  def start_link(user_id) do
    GenServer.start_link(__MODULE__, {user_id}, name: __MODULE__)
  end

  def send_message(message) do
    GenServer.cast __MODULE__, {:send_message, message}
  end

  def handle_cast({:send_message, message}, {user_id}) do
    {:ok, _} = TelegramApi.send_message(user_id, message)

    {:noreply, {user_id}}
  end
end