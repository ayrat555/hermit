defmodule Hermit.UpdateFetcher do
  alias BalalaikaBear.Messages

  def updates(token) when is_binary(token) do
    {
      :ok,
      server_params
    } = Messages.get_long_poll_server(token)

    updates(server_params)
  end

  def updates(%{"key" => key, "server" => server, "ts" => ts} = server_params) do
    {:ok, result} = Messages.get_long_poll_history(server, ts, key)
    server_params |> Map.merge(result)
  end
end
