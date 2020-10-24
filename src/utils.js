import * as crypto from "crypto";

// approach one :(
export function makeShort(length) {
  let result = "";
  const characters =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  const charactersLength = characters.length;
  for (let i = 0; i < length; i++) {
    result += characters.charAt(Math.floor(Math.random() * charactersLength));
  }
  return result;
}

// approach two - slightly better
export function makeHash(url) {
  const hash = crypto.createHash("md5").update(url).digest("base64");
  // make url safe
  return  hash.replace(/\//g, "_").replace(/\+/g, "-");
}
