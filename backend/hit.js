const mongoose = require("mongoose");
const Profile = require("./db/models/Profile");
const Student = require("./db/models/Student");
const bcrypt = require("bcrypt");

const fufu = async (req, res) => {
  const hashedPassword = await bcrypt.hash("mypass", 5);

  try {
    const student = new Student({
      name: "Naimish Mishra",
      uid: "21BCG1018",
      mobileNo: "5689231245",
      guardianNo: "1245785623",
      hostelDetails: {
        hostelName: "Govind-B",
        roomNo: 301,
      },
    });

    await student.save().then(() => {
      res.send("saved");
    });
  } catch (error) {
    console.error("Error creating profile:", error);
  }
};

module.exports = fufu;

