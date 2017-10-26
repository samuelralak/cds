# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :cds,
  ecto_repos: [Cds.Repo]

# Configures the endpoint
config :cds, CdsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kX6SUMEpfQI8yLW6h7VP4BLrvdIlzo+1TMS0G0eP2U0+58NZMKLfU+HTixoEdszQ",
  render_errors: [view: CdsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Cds.PubSub,
           adapter: Phoenix.PubSub.PG2]


# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  	issuer: "Cds",
  	ttl: { 30, :days },
  	verify_issuer: true,
  	secret_key: "JMF9Gqn/kmX00iDdqabz2JCPsVPVwQD6M3+OiqCdwBbsMatvMvXKQtJqj8OobCBM",
  	serializer: Cds.GuardianSerializer,
	permissions: %{
		default: [:read],
		admin: [:read, :write, :manage]
    }

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
