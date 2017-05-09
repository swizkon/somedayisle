# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :someday_isle,
  ecto_repos: [SomedayIsle.Repo]

# Configures the endpoint
config :someday_isle, SomedayIsle.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "N5oENYsaQHnLE2KAGx9iDcwWZNK+QExKQGO0/ZhaArFfdFOizlaY0v4h4HWqfxJp",
  render_errors: [view: SomedayIsle.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SomedayIsle.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
