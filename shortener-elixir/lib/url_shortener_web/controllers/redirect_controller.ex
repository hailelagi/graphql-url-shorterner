defmodule UrlShortenerWeb.RedirectController do
  use UrlShortenerWeb, :controller

  import Ecto.Query
  alias UrlShortener.{Repo, Url}

  def index(conn, %{"short_link" => short_link}) do
    case Repo.one(from url in Url, where: url.short_link == ^short_link) do
    nil -> json(conn, "Could not find this short link")
    link -> redirect(conn, external: "https://#{link.original_link}")
    end
  end
end
