defmodule WebconfPhx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      WebconfPhxWeb.Telemetry,
      # Start the Ecto repository
      WebconfPhx.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: WebconfPhx.PubSub},
      # Start Finch
      {Finch, name: WebconfPhx.Finch},
      # Start the Endpoint (http/https)
      WebconfPhxWeb.Endpoint
      # Start a worker by calling: WebconfPhx.Worker.start_link(arg)
      # {WebconfPhx.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WebconfPhx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WebconfPhxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
