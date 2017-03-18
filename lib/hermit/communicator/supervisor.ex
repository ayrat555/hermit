defmodule Hermit.Communicator.Supervisor do
  alias Hermit.Providers.VK.Provider
  alias Hermit.Consumers.Telegram.Consumer
  alias Hermit.Server
  alias Hermit.Config

  def start({provider_name, provider_opts}, {consumer_name, consumer_opts}) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Provider, [Config.vk_access_token]),
      worker(Consumer, [Config.telegram_user_id]),
      worker(Server, [])
    ]

    opts = [strategy: :one_for_one, name: Hermit.Supervisor]
    {:ok, _pid} = Supervisor.start_link(children, opts)
  end

  def provider(provider_name) do
    parsed_provider = provider_name |> Macro.camelize
    String.to_existing_atom("Hermit.Providers.#{parsed_provider}")
  end

  def consumer(consumer_name) do
    parsed_consumer = consumer_name |> Macro.camelize
    String.to_existing_atom("Hermit.Consumer.#{parsed_consumer}")
  end
end

