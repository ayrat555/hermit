defmodule HermitTest do
  use ExUnit.Case
  alias Hermit.Config

  test "starts supervisor" do
    provider_params = {:vk, [Config.vk_access_token]}
    consumer_params = {:telegram, [Config.telegram_user_id]}

    Hermit.start(provider_params, consumer_params)
  end
end
