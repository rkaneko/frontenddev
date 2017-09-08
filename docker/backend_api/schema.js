const {
  buildClientSchema
} = require("graphql");

const schemaJson = require("./graphql/schema.json");

const schema = buildClientSchema(schemaJson.data);
module.exports = schema;
