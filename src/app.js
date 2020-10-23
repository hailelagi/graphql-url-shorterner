import express from "express";
import { ApolloServer } from "apollo-server-express";
import { typeDefs } from "./schema";
import { createUrl } from "./resolvers/Mutation.js";
import { connect, test } from "./connect";
import Url from "../src/models/Url";

// is database running fine?
test();

// resolver functions for schema fields
const resolvers = {
  Query: {},
  Mutation: {
    createUrl,
  },
};

// apollo config
const server = new ApolloServer({
  typeDefs,
  resolvers,
  context: () => ({
    sequelize: connect(),
  }),
});

const app = express();

server.applyMiddleware({ app });

// url redirect
app.get("/:url", async (req, res) => {
  const url = req.params.url;

  // is this a graphql query?
  if (url === "graphql") {
    return
  }

  const urlExists = await Url.findOne({
    where: {
      shortLink: url,
    },
  });

  if (urlExists) {
    res.redirect("http://" + urlExists.originalLink);
  } else {
    res.json({ error: "Error, url not found, please create one" });
  }
});

app.listen({ port: 4000 }, () =>
  console.log(`🚀 Server ready at http://localhost:4000/graphql`)
);
