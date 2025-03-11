defmodule Cinema.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias Cinema.App

  @impl true
  def start(_type, _args) do
    children = [
      CinemaWeb.Telemetry,
      Cinema.Repo,
      {DNSCluster, query: Application.get_env(:cinema, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Cinema.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Cinema.Finch},
      # Start the commanded app
      {App.Supervisor, nil},
      # Start to serve requests, typically the last entry
      CinemaWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Cinema.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CinemaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
