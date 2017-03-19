defmodule Hermit.Providers.ProviderBase do
  def updates(provider) do
    GenServer.call provider, {:updates}
  end
end
