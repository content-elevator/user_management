defmodule UserManagement.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias UserManagement.Accounts.User

  import Comeonin.Bcrypt, only: [hashpwsalt: 1]


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

end
