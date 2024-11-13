const Pass = require("../../db/models/Pass");
const OpenedPass = require("../../db/models/OpenPass");
const ClosedPass = require("../../db/models/ClosedPass");
const date = require("../../utils/date");

const verifyPass = async (req, res) => {
  const uid = req.body.uid.toUpperCase();
  const guard = req.body.guard;

  try {
    // Searching in generated passes
    const pass = await Pass.findOne({ uid });
    // if pass exist transfer it to openedpasses
    if (pass) {
      const newOpenedPass = new OpenedPass({
        ...pass.toObject(),
        status: "o",
        openedBy: guard,
        openingDate: await date(),
      });
      
      newOpenedPass
        .save()
        .then(async () => {
          await Pass.deleteOne({ uid });
          res.status(200).json({ message: "Pass veriffied/opened" });
        })
        .catch((e) => {
          console.log(e);
          res.status(500).json({ message: "Server error" });
        });

      // If pass dont exist in generatedPasses then checking in openedpasses
    } else {
      const openedPass = await OpenedPass.findOne({ uid });

      // if exist here transfer it to closedpasses
      if (openedPass) {
        const newClosedPass = new ClosedPass({
          ...openedPass.toObject(),
          status: "c",
          closedBy: guard,
          closingDate: await date(),
        });

        newClosedPass
          .save()
          .then(async () => {
            await OpenedPass.deleteOne({ uid });
            res.status(200).json({ message: "Pass veriffied/closed" });
          })
          .catch((e) => {
            console.log(e)
            res.status(500).json({ message: "Server error" });
          });
      } else {
        return res.status(404).json({ message: "Pass not generated" });
      }
    }
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Server error" });
  }
};

module.exports = verifyPass;
