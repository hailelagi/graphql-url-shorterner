defmodule UrlShortenerWeb.RedirectControllerTest do
  use UrlShortenerWeb.ConnCase

  test "redirects a short link", %{conn: conn} do
    UrlShortener.Repo.insert!(%UrlShortener.Url{original_link: "www.example.com", short_link: "test04"})
    conn = get(conn, "/test04")

    assert redirected_to(conn, 302) =~ "https://www.example.com"
  end

  test "returns an error response for an unknown short link", %{conn: conn} do
    conn = get(conn, "/r@ndom")

    assert json_response(conn, 200) =~ "Could not find this short link"
  end
end
