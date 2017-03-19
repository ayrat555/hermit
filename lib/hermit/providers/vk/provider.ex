defmodule Hermit.Providers.Vk.Provider do
  use GenServer
  alias Hermit.Providers.Vk.API

  def start_link(name, token) do
    GenServer.start_link(__MODULE__, {token}, name: name)
  end

  def updates(name) do
    GenServer.call name, {:updates}
  end

  def handle_call({:updates}, _from, {token}) do
    {server, key, ts} = API.long_poll_server_data(token)
    {ts, update} = API.long_poll_history(server, key, ts)

    {:reply, update, {server, key, ts}}
  end

  def handle_call({:updates}, _from, {server, key, ts}) do
    {ts, update} = API.long_poll_history(server, key, ts)

    {:reply, update, {server, key, ts}}
  end
end
