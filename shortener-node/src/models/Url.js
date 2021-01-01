import { DataTypes } from "sequelize";
import { connect } from "../connect";

const sequelize = connect();

const Url = sequelize.define("Url", {
  shortLink: {
    type: DataTypes.STRING,
    unique: true,
    allowNull: false
  },
  originalLink: {
    type: DataTypes.STRING,
    unique: true,
    allowNull: false,
    isUrl: true
  },
});

Url.sync();

export default Url;