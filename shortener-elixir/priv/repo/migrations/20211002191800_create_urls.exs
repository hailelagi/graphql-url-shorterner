defmodule UrlShortener.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :original_link, :string, null: false
      add :short_link, :string, null: false

      timestamps()
    end

    create unique_index(:urls, [:original_link, :short_link], name: :link_index)
  end
end
