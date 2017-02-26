defmodule Hermit.Consumers.Telegram.ConsumerTest do
  use ExUnit.Case, async: true
  alias Hermit.Consumers.Telegram.Consumer
  import Mock

  test "send multiple messaged to telegram chat" do
    with_mock Nadia, [send_message: fn(_, _) -> {:ok, "received"} end] do
      messages = ["message1", "message2"]

      messages |> Consumer.send_messages

      messages
      |> Enum.each(fn(message) ->
        assert called Nadia.send_message(:_, message)
      end)
    end
  end
 end
