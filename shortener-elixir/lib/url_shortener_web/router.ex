defmodule UrlShortenerWeb.Router do
  use UrlShortenerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/graphql", Absinthe.Plug,
            schema: UrlShortenerWeb.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
            schema: UrlShortenerWeb.Schema,
            interface: :simple,
            context: %{pubsub: UrlShortenerWeb.Endpoint}
  end

  scope "/", UrlShortenerWeb do
    pipe_through :api

    get "/:short_link", RedirectController, :index
  end

  scope "/api", UrlShortenerWeb do
    pipe_through :api
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: UrlShortenerWeb.Telemetry
    end
  end
end
