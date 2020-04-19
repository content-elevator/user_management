defmodule UserManagementWeb.Router do
  use UserManagementWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", UserManagementWeb do
    pipe_through :api
    post "/sign_up", UserController, :create
  end
end
