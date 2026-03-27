defmodule JamiecHuman.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      JamiecHumanWeb.Telemetry,
      JamiecHuman.Repo,
      {DNSCluster, query: Application.get_env(:jamiec_human, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: JamiecHuman.PubSub},
      # Start a worker by calling: JamiecHuman.Worker.start_link(arg)
      # {JamiecHuman.Worker, arg},
      # Start to serve requests, typically the last entry
      JamiecHumanWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: JamiecHuman.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JamiecHumanWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
