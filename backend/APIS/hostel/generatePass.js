const Pass = require("../../db/models/Pass");
const OpenPass = require("../../db/models/OpenPass")
const date = require("../../utils/date");

const generatePass = async (req, res) => {
  const uid = req.body.uid.toUpperCase();

  try {
    const existingNewPass = await Pass.findOne({ uid });
    const existingOpenPass = await OpenPass.findOne({ uid });

    if (existingNewPass || existingOpenPass)
      return res.status(409).json({ message: "Pass already exist" });
    else {
      const newPass = new Pass({
        ...req.body,
        warden: req.body.warden._id,
        createdOn: await date(),
        status: "n"
      });

      await newPass.save().then(() => {
        res.status(200).json({ message: "Pass generated" });
      });
    }
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Server error" });
  }
};

module.exports = generatePass;
