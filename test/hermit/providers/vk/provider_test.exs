defmodule Hermit.Providers.Vk.ProviderTest do
  use ExUnit.Case, async: true
  alias Hermit.Providers.Vk.Provider
  alias BalalaikaBear.Messages
  import Mock

  @provider_name :test_provider
  @updates [[4, 88, 777]]

  test "fetches updates from vk" do
    with_mock Messages, [get_long_poll_server: fn(_) ->
                          {:ok, %{"server" => "server",
                                  "key" => "key",
                                  "ts" => "ts"}}
                        end,
                         get_long_poll_history: fn(_, _, _) ->
                           {:ok, %{"ts" => "ts",
                                   "updates" => @updates}}
                         end] do
      Provider.start_link(@provider_name, "some_token")

      assert Provider.updates(@provider_name) == ["You have a new message"]
    end
  end
end
