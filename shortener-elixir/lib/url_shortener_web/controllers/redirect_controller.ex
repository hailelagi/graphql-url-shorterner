defmodule UrlShortenerWeb.RedirectController do
  use UrlShortenerWeb, :controller

  import Ecto.Query
  alias UrlShortener.Repo


  def index(conn, %{"short_link" => short_link}) do
    case Repo.one!(from url in Url, where: url.short_link == ^short_link) do
      nil -> json(conn, "Could not find this short link #{short_link}")
      link -> redirect(conn, to: link.original_link)
    end
  end
end