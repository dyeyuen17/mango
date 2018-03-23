defmodule MangoWeb.Plugs.LoadCustomer do
  import Plug.Conn
  alias Mango.CRM

  def init(_) do
    nil
  end

  def call(%Plug.Conn{} = conn, _) do
    customer_id = get_session(conn, :customer_id)
    customer = customer_id && CRM.get_customer(customer_id)
    assign(conn, :current_customer, customer)
  end
end
