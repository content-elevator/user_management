defmodule UserManagementWeb.Router do
  use UserManagementWeb, :router

  alias UserManagement.Guardian

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/userApi/v1", UserManagementWeb do
    pipe_through :api
    post "/sign_up", UserController, :create
    post "/sign_in", UserController, :sign_in
  end

  scope "/userApi/v1", UserManagementWeb do
    pipe_through [:api, :jwt_authenticated]
    get "/my_user", UserController, :show
    put "/update", UserController, :update_profile
    put "/update/password", UserController, :update_password
    delete "/delete", UserController, :delete
  end
end
