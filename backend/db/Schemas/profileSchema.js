const mongoose = require("mongoose");

const profileSchema = new mongoose.Schema({
  eid: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    required: true,
  },
  name: {
    type: String,
    required: true,
  },
  role: {
    type: String,
    required: true,
  },
  hostelName: {
    type: String,
    required: false,
  },
});

module.exports = profileSchema;
