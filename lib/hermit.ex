defmodule Hermit do
  use GenServer
  alias Hermit.UpdateFetcher
  alias Hermit.TelegramApi

  def start_link(chat_id) do
    GenServer.start_link(__MODULE__, chat_id, [])
  end

  def listen_to_updates(server, token) do
    GenServer.cast(server, {:listen, token})
  end

  def get_updates(server, token) do
    GenServer.cast(server, {:listen, token})
  end

  def init(chat_id) do
    {:ok, chat_id}
  end

  def handle_cast({:listen, params}, chat_id) do
    result = UpdateFetcher.updates(params)
    %{"updates" => updates} = result
    if Enum.count(updates) > 0, do: TelegramApi.send_message(chat_id, "new update")
    GenServer.cast(self, {:listen, result})
    {:noreply, chat_id}
  end

  def handle_call({:listen, params}, chat_id) do
    result = UpdateFetcher.updates(params)
    %{"updates" => updates} = result
    if Enum.count(updates) > 0, do: TelegramApi.send_message(chat_id, "new update")
    {:reply, result, chat_id}
  end
end
