# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :circle_matcher,
  ecto_repos: [CircleMatcher.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :circle_matcher, CircleMatcherWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EmdPJglA2b1qv4oZJNQYl84AOijgEcNXMx6TUGCiSpqkMugBkZpQILekLvolLbjG",
  render_errors: [view: CircleMatcherWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: CircleMatcher.PubSub,
  live_view: [signing_salt: "PNGHZKoF"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
