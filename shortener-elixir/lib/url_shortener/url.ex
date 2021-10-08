defmodule UrlShortener.Url do
  use Ecto.Schema
  import Ecto.Changeset

  schema "urls" do
    field :original_link, :string
    field :short_link, :string

    timestamps()
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:original_link, :short_link])
    |> validate_required([:original_link, :short_link])
    |> unique_constraint([:original_link, :short_link], name: :link_index)
    |> validate_length(:short_link, is: 6)
  end
end
