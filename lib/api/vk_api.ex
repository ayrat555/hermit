defmodule Hermit.Api.VkApi do
  alias BalalaikaBear.Messages

  def long_poll_history(server, key, ts) do
    {:ok,
     %{"ts" => ts,
       "updates" => updates}} = Messages.get_long_poll_history(server, key, ts)

    {ts, updates}
  end

  def long_poll_server_data(token) do
    {:ok,
     %{"server" => server,
       "key" => key,
       "ts" => ts}} = Messages.get_long_poll_server(%{access_token: token})

    {server, key, ts}
  end
end
