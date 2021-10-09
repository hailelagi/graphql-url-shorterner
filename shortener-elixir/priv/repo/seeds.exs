# Script for populating the database. You can run it as:
# mix run priv/repo/seeds.exs

UrlShortener.Repo.insert!(%UrlShortener.Url{original_link: "www.example.com", short_link: "test01"})
UrlShortener.Repo.insert!(%UrlShortener.Url{original_link: "www.google.com", short_link: "test02"})
