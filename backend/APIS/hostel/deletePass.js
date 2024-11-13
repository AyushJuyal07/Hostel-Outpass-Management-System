const Pass = require("../../db/models/Pass");
const ClosedPass = require("../../db/models/ClosedPass");
const date = require("../../utils/date");

const deletePass = async (req, res) => {
  const uid = req.body.uid.toUpperCase();
  const warden = req.user._id;

  try {
    // Searching in generated passes
    const generatedPass = await Pass.findOne({ uid });
    if (generatedPass) {
      const newClosedPass = new ClosedPass({
        ...generatedPass.toObject(),
        status: "d",
        closedBy: warden,
        closingDate: await date(),
      });

      newClosedPass
        .save()
        .then(async () => {
          await Pass.deleteOne({ uid }).then(() => {
            return res.status(200).json({ message: "Pass deleted" });
          });
        })
        .catch((e) => {
          console.log(e);
          return res.status(500).json({ message: "Server error" });
        });
    }
    else{
        return res.status(404).json({ message: "No pass found to delete" });
    }
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Server error" });
  }
};

module.exports = deletePass;
