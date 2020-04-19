defmodule UserManagement.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias UserManagement.Accounts.User

  alias MyApi.Guardian
  import Comeonin.Bcrypt, only: [hashpwsalt: 1, checkpw: 2, dummy_checkpw: 0]


  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password_hash, :string
    field :username, :string
    # Virtual fields:
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password, :password_confirmation, :first_name, :last_name, :email])
    |> validate_required([:username, :password, :password_confirmation, :first_name, :last_name, :email])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password)
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}}
      ->
        put_change(changeset, :password_hash, hashpwsalt(pass))
      _ ->
        changeset
    end
  end

  def token_sign_in(username, password) do
    case username_password_auth(username, password) do
      {:ok, user} ->
        Guardian.encode_and_sign(user)
      _ ->
        {:error, :unauthorized}
    end
  end

  defp username_password_auth(username, password) when is_binary(username) and is_binary(password) do
    with {:ok, user} <- get_by_username(username),
         do: verify_password(password, user)
  end

  defp get_by_username(username) when is_binary(username) do
    case Repo.get_by(User, username: username) do
      nil ->
        dummy_checkpw()
        {:error, "Login error"}
      user ->
        {:ok, user}
    end
  end

  defp verify_password(password, %User{} = user) when is_binary(password) do
    if checkpw(password, user.password_hash) do
      {:ok, user}
    else
      {:error, :invalid_password}
    end
  end

end
