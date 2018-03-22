defmodule Mango.CRM.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  alias Mango.CRM.Customer


  schema "customers" do
    field :email, :string
    field :name, :string
    field :password_hash, :string
    field :phone, :string
    field :residence_area, :string

    timestamps()
  end

  @doc false
  def changeset(%Customer {} = customer, attrs) do
    customer
    |> cast(attrs, [:name, :email, :phone, :residence_area, :password_hash])
    |> validate_required([:name, :email, :phone, :residence_area, :password_hash])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/\S+@\S+\.\S{1,4}+/, message: "is invalid")
    |> validate_length(:password_hash, min: 6, max: 100)
    |> encrypt_password()
  end

  defp encrypt_password(changeset) do
    case changeset do
       %Ecto.Changeset{valid?: true, changes: %{password_hash: password_hash}} ->
         put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password_hash))
      _ ->
      changeset
    end
  end
end
