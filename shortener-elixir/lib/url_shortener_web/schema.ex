defmodule UrlShortenerWeb.Schema do
  use Absinthe.Schema

  alias UrlShortenerWeb.Resolvers.ShortUrl

  object :link do
    field :short_link, :string
    field :original_link, :string
  end

  query do
    @desc "Return a link if it has been shortened"
    field :get_link, :link do
      arg :link, non_null(:string)
      resolve &ShortUrl.index/2
    end
  end

  mutation do
    @desc "Create a short url link"
    field :create_short_url, :link do
      arg :url, non_null(:string)

      resolve &ShortUrl.create/2
    end
  end
end
