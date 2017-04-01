defmodule Hermit.Communicator.ServerTest.Consumer do
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, {}, name: name)
  end

  def healthcheck(name) do
    GenServer.call name, :healthcheck
  end

  def handle_cast({:send_messages, updates}, state) do
    {:noreply, updates}
  end

  def handle_call(:healthcheck, _from, state) do
    {:reply, state, state}
  end
end
