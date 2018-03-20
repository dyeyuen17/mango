# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :mango,
  ecto_repos: [Mango.Repo]

# Configures the endpoint
config :mango, MangoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "iXTHhakkm2TaVxGkn9MszAdjZ7kXJIxZTMS2RLm55fJQEt5L9/hLILtB9218Kux6",
  render_errors: [view: MangoWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Mango.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :hound,
  driver: "phantom-js",
  host: "http://localhost",
  port: 8910,
  path_prefix: "wd/hub/"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
