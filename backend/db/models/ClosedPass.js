const mongoose = require("mongoose");
const passSchema = require("../Schemas/PassSchema");

module.exports = mongoose.model("closedpass", passSchema);
