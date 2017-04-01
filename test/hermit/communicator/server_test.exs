defmodule Hermit.Communicator.ServerTest do
  use ExUnit.Case, async: true
  alias Hermit.Communicator.Server
  alias Hermit.Communicator.ServerTest.Provider
  alias Hermit.Communicator.ServerTest.Consumer

  @provider_name :provider
  @consumer_name :consumer

  setup_all do
    Provider.start_link @provider_name
    Consumer.start_link @consumer_name

    :ok
  end

  test "forwards updates from provider to consumer" do
    Server.start_link @provider_name, @consumer_name, 1

    updates_in_provider = Provider.updates(@provider_name)
    updates_in_consumer = Consumer.healthcheck(@consumer_name)

    assert updates_in_provider == updates_in_consumer
  end
end


