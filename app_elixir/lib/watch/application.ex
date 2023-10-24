defmodule Watch.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias Watch.Prometheus.{
    PhoenixInstrumenter,
    PipelineInstrumenter,
    Exporter
  }

  require Prometheus.Registry

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      WatchWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Watch.PubSub},
      # Start the Endpoint (http/https)
      WatchWeb.Endpoint
      # Start a worker by calling: Watch.Worker.start_link(arg)
      # {Watch.Worker, arg}
    ]

    PhoenixInstrumenter.setup()
    PipelineInstrumenter.setup()

    if :os.type() == {:unix, :linux} do
      Prometheus.Registry.register_collector(:prometheus_process_collector)
    end

    Exporter.setup()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Watch.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WatchWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
