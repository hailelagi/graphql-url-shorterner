# README

## Installation

* This is running Ruby '2.7.2'. To start `bundle install` in relative directory `./graphql-url-shorterner/shortener-ruby`.

* Create a database `bin/rails db:create` or connect to custom one of your choice. By changing the config.
```
  username: <%= ENV['POSTGRES_USER'] %>
  password: <%= ENV['POSTGRES_PASSWORD'] %>
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  <<: *default
  database: shortener_ruby_development

```

The db connection string would look something like this:

```
DEV_DATABASE_URL=postgres://<username>:<password>@127.0.0.1:5432/<dev_db>
```

* Run migrations (incase) `bin/rails db:migrate`

* `bin/rails server` to start the server.

## Routes

```
  get "/:user_link", to: "hand_over#index"
```

GraphQL Fields
```
getAllUrls: [Url!]
getUrl(urlId: Int!): Url!
createUrl(input: CreateUrlInput!): Url
```
