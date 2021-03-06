defmodule Hermit.Mixfile do
  use Mix.Project

  def project do
    [app: :hermit,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:balalaika_bear, git: "https://github.com/ayrat555/balalaika_bear.git"},
     {:nadia, "~> 0.4.2"},
     {:apex, "~>0.6.0", only: [:dev, :test]},
     {:credo, "~> 0.5", only: [:dev, :test]},
     {:mock, "~> 0.2.0", only: :test}]
  end
end
