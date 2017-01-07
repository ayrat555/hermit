defmodule Hermit.UpdateFetcher do
  alias BalalaikaBear.Messages

  def updates(token) do
    {:ok, 
      %{"server" => server, 
        "key" => key, 
        "ts" => ts}} = Messages.get_long_poll_server(%{access_token: token}) 

    Messages.get_long_poll_history(server, key, ts)
  end
end
