import Url from "../../src/models/Url";
import { makeShort } from "../utils";

export async function createUrl(_, args) {
  let longUrl = args.url;

  const isUrl = new RegExp(
    /[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)?/gi
  );

  if (!longUrl.match(isUrl)) {
    return "invalid url entered";
  }

  const urlExists = await Url.findOne({
    where: {
      originalLink: args.url,
    },
  });

  if (urlExists) {
    return "http://localhost:4000/" + urlExists.shortLink;
  } else {
    return await newUrl();
  }

  async function newUrl() {
    let shortUrl = makeShort(6);

    // does short url already exist in the database?
    const urlClash = await Url.findAll({
      where: {
        shortLink: shortUrl,
      },
    });

    if (urlClash.shortLink === shortUrl) {
      // make a new shortUrl
      return newUrl();
    }

    const userUrl = await Url.build({
      shortLink: shortUrl,
      originalLink: longUrl,
    });

    await userUrl.save();

    const userShortLink = userUrl.dataValues.shortLink;
    if (userShortLink) {
      return "http://localhost:4000/" + userShortLink;
    } else {
      return { error: "could not save link please try again" };
    }
  }
}
