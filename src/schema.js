import { gql } from "apollo-server-express";

// schema definition
export const typeDefs = gql`  
  type Query {
    default: String
  }

  type Mutation {
    createUrl(url: String!): String!
  }
    
`;
