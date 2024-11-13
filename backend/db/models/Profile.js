const mongoose = require("mongoose");
const profileSchema = require("../Schemas/profileSchema")

module.exports = mongoose.model("profile", profileSchema);
