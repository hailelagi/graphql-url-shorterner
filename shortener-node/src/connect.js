import dotenv from "dotenv";
import { Sequelize } from "sequelize";

dotenv.config();

export function connect() {
  return new Sequelize(process.env.DEV_DATABASE_URL);
}

export function test() {
  const sequelize = connect();
  try {
    sequelize.authenticate().then(null);
    console.log("Connection has been established successfully 🚀");
  } catch (error) {
    console.error("Unable to connect to the database:", error);
  }
}
