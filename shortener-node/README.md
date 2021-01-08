# GraphQL Url Shortener

## Installation

* `npm i --save` in the relative directory `graphql-url-shorterner/shortener-node`.

* Create a database with username `postgres` called `dev_db` or connect to custom one of your choice. By changing the config.

* It is likely you may need to configure environment variables in a `.env` file

```
DEV_DATABASE_URL=postgres://<username>:<password>@127.0.0.1:5432/<dev_db>
```

* `node index.js` to start the server.

* Run tests for the shortener `jest`
