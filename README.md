# Hermit
[![Build Status](https://semaphoreci.com/api/v1/ayrat555/hermit/branches/master/badge.svg)](https://semaphoreci.com/ayrat555/hermit)

The main idea of this project is to create extensible tool that helps to connect different services.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `hermit` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:hermit, "~> 0.1.0"}]
    end
    ```

  2. Ensure `hermit` is started before your application:

    ```elixir
    def application do
      [applications: [:hermit]]
    end
    ```
