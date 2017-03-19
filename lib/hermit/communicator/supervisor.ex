defmodule Hermit.Communicator.Supervisor do
  alias Hermit.Communicator.Server

  def start({provider_name, provider_opts}, {consumer_name, consumer_opts}) do
    import Supervisor.Spec, warn: false
    provider_process_name = random_number
    consumer_process_name = random_number

    children = [
      worker(provider(provider_name), [provider_process_name] ++ provider_opts),
      worker(consumer(consumer_name), [consumer_process_name] ++ consumer_opts),
      worker(Server, [provider_process_name, consumer_process_name])
    ]

    opts = [strategy: :one_for_one, name: Hermit.Supervisor]
    {:ok, _pid} = Supervisor.start_link(children, opts)
  end

  defp provider(provider_name) do
    parsed_provider = provider_name |> prepare_name

    ["Hermit.Providers", parsed_provider, "Provider"] |> Module.concat
  end

  defp consumer(consumer_name) do
    parsed_consumer = consumer_name |> prepare_name

    ["Hermit.Consumers", parsed_consumer, "Consumer"] |> Module.concat
  end

  defp prepare_name(name) do
    name
    |> Atom.to_string
    |> Macro.camelize
  end

  defp random_number(upper_lim \\ 1_000_000) do
    upper_lim
    |> :rand.uniform
    |> Integer.to_string
    |> String.to_atom
  end
end

