defmodule UserManagementWeb.UserView do
  use UserManagementWeb, :view
  alias UserManagementWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      password_hash: user.password_hash,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email}
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end
end
