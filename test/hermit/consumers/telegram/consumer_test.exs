defmodule Hermit.Consumers.Telegram.ConsumerTest do
  use ExUnit.Case, async: true
  alias Hermit.Consumers.Telegram.Consumer
  import Mock

  @consumer_name :test_consumer

  setup_all do
    Consumer.start_link(@consumer_name, 7777)

    :ok
  end

  test "send multiple messaged to telegram chat" do
    with_mock Nadia, [send_message: fn(_, _) -> {:ok, "received"} end] do
      messages = ["message1", "message2"]

      Consumer.send_messages @consumer_name, messages

      messages
      |> Enum.each(fn(message) ->
        assert called Nadia.send_message(:_, message)
      end)
    end
  end
 end
