const casual = require("casual");

const mocks = {
  AuthorNode: () => ({

  }),
  DateTime: () => casual.date("YYYY-MM-DD"),
};

module.exports = mocks;
