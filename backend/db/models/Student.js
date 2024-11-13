const mongoose = require("mongoose");
const studentDetailsSchema = require("../Schemas/StudentSchema")

module.exports = mongoose.model("students", studentDetailsSchema);
