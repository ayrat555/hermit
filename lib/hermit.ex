defmodule Hermit do
  alias Hermit.Communicator.Supervisor

  def start(provider, consumer) do
    Supervisor.start_link(provider, consumer)
  end
end

