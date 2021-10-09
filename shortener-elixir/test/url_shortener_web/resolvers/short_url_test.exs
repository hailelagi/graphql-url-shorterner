defmodule UrlShortenerWeb.Resolvers.ShortUrlTest do
  use UrlShortener.DataCase

  alias UrlShortenerWeb.Resolvers.ShortUrl

  describe "createShortLink resolver test" do
    test "creates a short link" do
      args = %{url: "www.test5.com"}

      assert {:ok, %{original_link: "www.test5.com"}} = ShortUrl.create(args, nil)
    end

    test "does not create a duplicate short link" do
      args = %{url: "www.test1.com"}
      ShortUrl.create(args, nil)

      assert {:error, _message} = ShortUrl.create(args, nil)
    end
  end


  describe "getShortLink resolver test" do
    test "gets a short link" do
      Repo.insert!(%UrlShortener.Url{original_link: "www.test2.com", short_link: "test02"})
      args = %{link: "test02"}

      assert {:ok, %{original_link: "www.test2.com", short_link: "test02"}} = ShortUrl.index(args, nil)
    end

    test "does not get a non-existent link" do
      args = %{link: "r@ndom"}

      assert {:error, _message} = ShortUrl.index(args, nil)
    end
  end
end
