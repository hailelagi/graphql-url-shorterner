import { makeShort } from "../utils";

// Make Short unit tests
describe("Does it create random short urls?", () => {
  // unit tests
  test("returns a random string 'url' ", () => {
    expect(makeShort(6)).toHaveLength(6);
    expect(makeShort(6)).toBeDefined();
    expect(makeShort(6)).toBeTruthy();
  });
});
