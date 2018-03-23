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

  def get_customer_by_email(email) do
    Repo.get_by(Customer, email: email)
  end

  def get_customer_by_credentials(%{"email" => email, "password_hash" => password}) do
    customer = get_customer_by_email(email)
    cond do
      customer && Comeonin.Bcrypt.checkpw(password, customer.password_hash) ->
        customer
      true ->
        :error
    end
  end

  def get_customer(id) do
    Customer |> Repo.get(id)
  end

end
