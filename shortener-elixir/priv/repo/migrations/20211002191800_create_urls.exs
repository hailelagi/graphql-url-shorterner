defmodule UrlShortener.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :original_link, :string
      add :short_link, :string

      timestamps()
    end

  end
end
