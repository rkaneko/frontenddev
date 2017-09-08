const express = require("express");
const graphqlHTTP = require("express-graphql");
const {
  addMockFunctionsToSchema
} = require("graphql-tools");

const schema = require("./schema");
const mocks = require("./mocks");

addMockFunctionsToSchema({
  schema,
  mocks,
  preserveResolvers: true,
});

const port = 3000;
const app = express();
app.use("/graphql", graphqlHTTP({
  schema,
  graphiql: true,
})
);
app.listen(port, err => {
  if (err) {
    console.error(err);
  } else {
    console.info("==> 🌎  Listening on port %s. Open up http://localhost:%s/graphql in your browser.", port, port);
  }
});
process.on("SIGINT", () => process.exit(0));

