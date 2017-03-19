defmodule Hermit.Consumers.ConsumerBase do
  def send_messages(consumer, updates) do
    GenServer.cast consumer, {:send_messages, updates}
  end
end
