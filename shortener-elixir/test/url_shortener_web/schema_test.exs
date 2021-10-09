defmodule UrlShortenerWeb.SchemaTest do
  use UrlShortenerWeb.ConnCase

  @get_link_test """
  query getLink($link: String!) {
    getLink(link: $link) {
      originalLink
      shortLink
    }
  }
  """

  @create_short_url_test"""
  mutation($url: String!) {
    createShortUrl(url: $url) {
      originalLink
      shortLink
    }
  }
  """

  test "creates a short link", %{conn: conn} do
    conn = post(conn, "/graphql", %{
      "query" => @create_short_url_test,
      "variables" => %{url: "www.example.com"}
    })

    res = json_response(conn, 200)

    assert res["data"]["createShortUrl"]["originalLink"] == "www.example.com"
  end

  test "retrieves the original link", %{conn: conn} do
    UrlShortener.Repo.insert!(%UrlShortener.Url{original_link: "www.test.com", short_link: "test05"})

    conn = post(conn, "/graphql", %{
      "query" => @get_link_test,
      "variables" => %{link: "test05"}
    })

    res = json_response(conn, 200)

    assert res["data"]["getLink"]["originalLink"] == "www.test.com"
  end
end
