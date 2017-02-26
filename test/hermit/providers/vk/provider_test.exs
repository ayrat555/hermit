defmodule Hermit.Providers.VK.ProviderTest do
  use ExUnit.Case, async: true
  alias Hermit.Providers.VK.Provider
  alias BalalaikaBear.Messages
  import Mock

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
      assert Provider.updates == ["You have a new message"]
    end
  end
end
