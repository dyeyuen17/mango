defmodule Mango.CRM do
  alias Mango.CRM.Customer
  alias Mango.Repo

  def build_customer(attrs \\ %{}) do
    %Customer{}
      |> Customer.changeset(attrs)
  end

  def create_customer(attrs \\ %{}) do
    %Customer{}
      |> Customer.changeset(attrs)
      |> Repo.insert()
  end

  def list_users() do
    Repo.all(Customer)
  end

end
