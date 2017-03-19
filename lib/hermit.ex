defmodule Hermit do
  alias Hermit.Communicator.Supervisor

  def start(provider, consumer) do
    Supervisor.start(provider, consumer)
  end
end

