# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :user_management,
  ecto_repos: [UserManagement.Repo]

# Configures the endpoint
config :user_management, UserManagementWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ASZcFFBCOp0L1T+514xPNRh/23XvyM4UWp0PE4dvFzIHMhuwCG7ABLRnwgq41e8U",
  render_errors: [view: UserManagementWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: UserManagement.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "oCfVawWa"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# Guardian config
config :user_management, UserManagement.Guardian,
  issuer: "user_management",
  secret_key: "vdsNJHUptbte5p55rYvsoKF+UiaZB/Se7ZwFDtox8ZR1kgh41hcl7rnbhubM6OR4"

config :new_relic_agent,
  app_name: "User Management Elixir App",
  license_key: "eu01xxa31792eae8c04ac5416a05c87a1d9eNRAL"