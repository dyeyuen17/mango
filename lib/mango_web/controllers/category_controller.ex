defmodule MangoWeb.CategoryController do
  use MangoWeb, :controller
  alias Mango.Catalog

  def show(conn, %{"name" => name}) do
    products = Catalog.get_category_products(name)
    render(conn, "show.html", products: products, name: name)
  end

end
