defmodule Hermit.Server do
  use GenServer
  alias Hermit.VkApi

  def start_link do
    GenServer.start_link(__MODULE__, {}, name: __MODULE__)
  end

  def listen(token) do
    GenServer.call __MODULE__, {:listen, token}
  end

  def handle_call({:listen, token}, _from, state) do
    {server, key, ts} = VkApi.long_poll_server_data(token)
    {ts, updates} = VkApi.long_poll_history(server, key, ts)
    {:reply, updates, {server, key, ts}}
  end
end
