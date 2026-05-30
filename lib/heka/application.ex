defmodule Heka.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HekaWeb.Telemetry,
      Heka.Repo,
      {DNSCluster, query: Application.get_env(:heka, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Heka.PubSub},
      # Start a worker by calling: Heka.Worker.start_link(arg)
      # {Heka.Worker, arg},
      # Start to serve requests, typically the last entry
      HekaWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Heka.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HekaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
