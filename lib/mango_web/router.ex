defmodule MangoWeb.Router do
  use MangoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :customer do
    plug MangoWeb.Plugs.LoadCustomer
    plug MangoWeb.Plugs.FetchCart
  end

  pipeline :auth do
    plug MangoWeb.Plugs.AuthenticateCustomer
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MangoWeb do
    pipe_through [:browser, :customer] # Use the default browser stack

    get "/", PageController, :index
    get("/categories/:name", CategoryController, :show)

    get("/register", RegistrationController, :new)
    post("/register", RegistrationController, :create)

    get("/login", SessionController, :new)
    post("/login", SessionController, :create)

    post("/cart", CartController, :add)
    get("/cart", CartController, :show)
    patch("/cart", CartController, :update)
    put("/cart", CartController, :update)

  end

  scope "/", MangoWeb do
    pipe_through [:browser, :customer, :auth]

    get("/logout", SessionController, :delete)
    get("/checkout", CheckoutController, :edit)
    put("/checkout/confirm", CheckoutController, :update)
    resources("/tickets", TicketController, except: [:edit, :update, :delete])
  end

  # Other scopes may use custom stacks.
  # scope "/api", MangoWeb do
  #   pipe_through :api
  # end
end
