defmodule Hermit.Config do
  def telegram_user_id do
    Application.fetch_env!(:hermit, :telegram_user_id)
  end

  def vk_access_token do
    Application.fetch_env!(:hermit, :vk_access_token)
  end
end
