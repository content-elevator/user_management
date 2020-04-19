defmodule UserManagement.Guardian.AuthPipeline do
  @moduledoc false
  use Guardian.Plug.Pipeline, otp_app: :user_management,
                              module: UserManagement.Guardian,
                              error_handler: UserManagement.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
