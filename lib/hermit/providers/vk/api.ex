defmodule Hermit.Providers.Vk.API do
  alias BalalaikaBear.Messages
  alias BalalaikaBear.Users

  def long_poll_history(server, key, ts) do
    {:ok,
     %{"ts" => ts,
       "updates" => updates}} = Messages.get_long_poll_history(server, key, ts)

    updates = updates |> parse_updates
    {ts, updates}
  end

  def long_poll_server_data(token) do
    {:ok,
     %{"server" => server,
       "key" => key,
       "ts" => ts}} = Messages.get_long_poll_server(%{access_token: token})

    {server, key, ts}
  end

  def get_user_info(user_id, token) do
    {:ok, users} = Users.get(%{user_ids: [user_id], access_token: token})
    users |> Enum.at(0)
  end

  def get_user_info(user_id) do
    {:ok, users} = Users.get(%{user_ids: [user_id]})
    users |> Enum.at(0)
  end

  defp parse_updates(updates) do
    updates
    |> Enum.map(&parse_update(&1))
    |> Enum.reject(&is_nil(&1))
  end

  defp parse_update([4 | _]) do
    "You have a new message"
  end

  defp parse_update(_params) do
    nil
  end
 end
