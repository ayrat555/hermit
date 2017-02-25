defmodule Hermit.Api.VkApi do
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
    {:ok, users} =  Users.get(%{user_ids: [user_id]})
    users |> Enum.at(0)
  end

  defp parse_updates(updates) do
    updates
    |> Enum.map(&parse_update(&1))
    |> Enum.reject(&is_nil(&1))
  end

  defp parse_update([9, user_id, flag]) do
    %{"first_name" => first_name,
      "last_name" => last_name} = get_user_info(-user_id)
    cause = case flag do
              0 -> "leaving"
              1 -> "timeout"
              _ -> "unknown"
            end

    "#{first_name} #{last_name} went offline by #{cause}"
  end

  defp parse_update([8, user_id, _extra]) do
    %{"first_name" => first_name,
      "last_name" => last_name} = get_user_info(-user_id)

    "#{first_name} #{last_name} went online"
  end

  defp parse_update(_params) do
    nil
  end
 end
