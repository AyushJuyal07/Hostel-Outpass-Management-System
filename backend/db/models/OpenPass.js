const mongoose = require("mongoose");
const PassSchema = require("../Schemas/PassSchema");

module.exports = mongoose.model("openedpass", PassSchema);
