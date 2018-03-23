defmodule MangoWeb.Plugs.LoadCustomerTest do
  use MangoWeb.ConnCase
  alias Mango.CRM

  @valid_attrs %{
    "name" => "John",
    "email" => "john@example.com",
    "password_hash" => "secret",
    "residence_area" => "BGCD",
    "phone" => "1111"
  }

  test "fetch customer from session on subsequent visit" do

    {:ok, customer} = CRM.create_customer(@valid_attrs)
    conn = post(build_conn(), "/login", %{"session" => @valid_attrs})
    conn = get(conn, "/")
    assert customer == conn.assigns.current_customer

  end
end
