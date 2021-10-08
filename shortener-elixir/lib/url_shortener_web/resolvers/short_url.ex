defmodule UrlShortenerWeb.Resolvers.ShortUrl do
  alias UrlShortener.{Repo, Url}
  import Ecto.Query
  import String, only: [slice: 2, downcase: 1]

  def index(%{link: link}, _resolution) do
    case Repo.one(from url in Url, where: url.short_link == ^link) do
      nil -> {:error, "Could not find this short link #{link}"}
      link -> {:ok, link}
    end
  end

  def create(_parent, %{url: url}, _resolution) do
    short = hash(url)

    changeset = Url.changeset(%Url{}, %{original_link: url, short_link: short})

    case Repo.insert(changeset) do
      {:error, changeset} -> {:error, format_changeset_error(changeset)}
      {:ok, link} -> {:ok, %{original_link: link.original_link, short_link: link.short_link}}
    end
  end

  defp format_changeset_error(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
    |> Enum.reduce("", fn {k, v}, acc ->
      joined_errors = Enum.join(v, "; ")
      "#{acc}#{k}: #{joined_errors}\n"
    end)
  end

  defp hash(link) do
    :crypto.hash(:sha, link)
    |> Base.encode16()
    |> slice(0..5)
    |> downcase
  end
end
