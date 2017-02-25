defmodule Hermit do
  use Application
  alias Hermit.Providers.VK.Provider
  alias Hermit.Consumers.Telegram.Consumer
  alias Hermit.Server
  alias Hermit.Config

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Provider, [Config.vk_access_token]),
      worker(Consumer, [Config.telegram_user_id]),
      worker(Server, [])
    ]

    opts = [strategy: :one_for_one, name: Hermit.Supervisor]
    {:ok, _pid} = Supervisor.start_link(children, opts)
  end
end
