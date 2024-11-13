const Pass = require("../../db/models/Pass");
const OpenedPass = require("../../db/models/OpenPass");

const getGeneratedPass = async (req, res) => {
  const uid = req.body.uid.toUpperCase();

  try {
    const openPass = await OpenedPass.findOne({ uid })
      .populate({
        path: "warden",
        select: "name",
      })
      .populate({
        path: "openedBy",
        select: "name",
      });
    const generatedPass = await Pass.findOne({ uid }).populate({
      path: "warden",
      select: "name",
    });
    if (openPass) {
      return res.status(200).json(openPass);
    } else if (generatedPass) {
      return res.status(200).json(generatedPass);
    } else {
      return res.status(404).json({ message: "Pass not generated" });
    }
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Server error" });
  }
};

module.exports = getGeneratedPass;
