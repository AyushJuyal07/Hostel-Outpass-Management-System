const Pass = require("../../db/models/Pass");
const OpenedPass = require("../../db/models/OpenPass");

const getPassList = async (req, res) => {
  const user = req.user;
  try {
    const openPass = await OpenedPass.find({
      "hostelDetails.hostelName": user.hostelName,
    })
      .populate({
        path: "warden",
        select: "name",
      })
      .populate({
        path: "openedBy",
        select: "name",
      });
    const generatedPass = await Pass.find({
      "hostelDetails.hostelName": user.hostelName,
    })
      .populate({
        path: "warden",
        select: "name",
      })
    return res.status(200).json([...generatedPass, ...openPass]);
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Server error" });
  }
};

module.exports = getPassList;
