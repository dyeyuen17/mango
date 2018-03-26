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


  alias Mango.CRM.Ticket

  @doc """
  Returns the list of tickets.

  ## Examples

      iex> list_tickets()
      [%Ticket{}, ...]

  """
  def list_customer_tickets(customer) do
    customer
      |> Ecto.assoc(:tickets)
      |> Repo.all()
  end

  @doc """
  Gets a single ticket.

  Raises `Ecto.NoResultsError` if the Ticket does not exist.

  ## Examples

      iex> get_ticket!(123)
      %Ticket{}

      iex> get_ticket!(456)
      ** (Ecto.NoResultsError)

  """
  def get_customer_ticket!(customer, id) do
    customer
      |> Ecto.assoc(:tickets)
      |> Repo.get!(id)
  end
  @doc """
  Creates a ticket.

  ## Examples

      iex> create_ticket(%{field: value})
      {:ok, %Ticket{}}

      iex> create_ticket(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_customer_ticket(%Customer{} = customer, attrs \\ %{}) do
    build_customer_ticket(customer, attrs)
    |> Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ticket changes.

  ## Examples

      iex> change_ticket(ticket)
      %Ecto.Changeset{source: %Ticket{}}

  """
  def build_customer_ticket(%Customer{} = customer, attrs \\ %{}) do
    Ecto.build_assoc(customer, :tickets, %{status: "New"})
      |> Ticket.changeset(attrs)
  end


end
