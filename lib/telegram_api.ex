defmodule Hermit.TelegramApi do
  def send_message(chat_id, message) do
    Nadia.send_message(chat_id, message)
  end
end
