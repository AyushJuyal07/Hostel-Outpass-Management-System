const mongoose = require("mongoose");
const profile = require("../models/Profile");

const passSchema = new mongoose.Schema({
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
  category: {
    type: String,
    required: true,
  },
  status: {
    type: String,
    required: true,
  },
  purpose: {
    type: String,
    required: true,
  },
  place: {
    type: String,
    required: true,
  },
  outTime: {
    type: String,
    required: true,
  },
  inTime: {
    type: String,
    required: true,
  },
  warden: {
    type: mongoose.Schema.Types.ObjectId,
    ref: profile,
    required: true,
  },
  createdOn: {
    type: Date,
    required: true,
  },
  openedBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: profile,
    required: false,
  },
  openingDate: {
    type: Date,
    required: false,
  },
  closedBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: profile,
    required: false,
  },
  closingDate: {
    type: Date,
    required: false,
  }
});

module.exports = passSchema;
