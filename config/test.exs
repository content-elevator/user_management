use Mix.Config

# Configure your database
config :user_management, UserManagement.Repo,
  username: "mac",
  password: "Postgres1234",
  database: "user_management_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :user_management, UserManagementWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
