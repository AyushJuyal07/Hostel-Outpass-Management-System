const mongoose = require("mongoose");

const studentDetailsSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  uid: {
    type: String,
    required: true,
  },
  mobileNo: {
    type: String,
    required: true,
  },
  guardianNo: {
    type: String,
    required: true,
  },
  hostelDetails: {
    hostelName: {
      type: String,
      required: true,
    },
    roomNo: {
      type: Number,
      required: true,
    },
  },
});

module.exports = studentDetailsSchema;
