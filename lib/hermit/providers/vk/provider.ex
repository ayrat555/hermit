defmodule Hermit.Providers.VK.Provider do
  use GenServer
  alias Hermit.Providers.VK.API

  def start_link(token) do
    GenServer.start_link(__MODULE__, {token}, name: __MODULE__)
  end

  def updates do
    GenServer.call __MODULE__, {:updates}
  end

  def handle_call({:updates}, _from, {token}) do
    {server, key, ts} = API.long_poll_server_data(token)
    {ts, updates} = API.long_poll_history(server, key, ts)

    {:reply, updates, {server, key, ts}}
  end

  def handle_call({:updates}, _from, {server, key, ts}) do
    {ts, updates} = API.long_poll_history(server, key, ts)

    {:reply, updates, {server, key, ts}}
  end
end
