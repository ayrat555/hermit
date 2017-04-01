defmodule Hermit.Communicator.ServerTest.Provider do
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, {}, name: name)
  end

  def updates(name) do
    GenServer.call name, {:updates}
  end

  def handle_call({:updates}, _from, _state) do
    {:reply, ["updates"], _state}
  end
end
