const Pass = require("../../db/models/Pass");

const editPass = async (req, res) => {
  const body = req.body;
  delete body["_id"];

  try {
    const generatedPass = await Pass.findOne({ uid: body.uid });

    if (generatedPass) {
      await Pass.updateOne({ uid: body.uid }, {...body, warden: req.user._id });
      return res.status(200).json({ message: "Pass updated" });
    } else {
      return res.status(404).json({ message: "Pass not found" });
    }
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Server error" });
  }
};

// 64a3c062a49dacdd373b5b20

module.exports = editPass;
