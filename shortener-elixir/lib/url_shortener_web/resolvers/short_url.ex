defmodule UrlShortenerWeb.Resolvers.ShortUrl do
  alias UrlShortener.{Repo, Url}
  import Ecto.Query
  import String, only: [slice: 2]

  def index(%{link: link}, _resolution) do
    case Repo.one(from url in Url, where: url.short_link == ^link) do
      nil -> {:error, "Could not find this short link #{link}"}
      link -> {:ok, link}
    end
  end

  def create(_parent, %{url: url}, _resolution) do
    short = hash(url)
    # TODO: validate changeset
    # changeset = Url.changeset(%Url{}, %{original_link: url, short_link: short})

    case Repo.insert!(%Url{original_link: url, short_link: short}) do
      nil -> {:error, "Could not create this url, reason: }"}
      links -> {:ok, %{original_link: links.url, short_link: links.short_url}}
    end
  end

  defp hash(link) do
    :crypto.hash(:sha, link)
    |> Base.encode16()
    |> slice(0..6)
  end
end