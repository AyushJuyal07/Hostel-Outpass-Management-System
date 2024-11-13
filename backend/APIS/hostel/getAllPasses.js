const ClosedPass = require("../../db/models/ClosedPass");

const getPassList = async (req, res) => {
  const user = req.user;
  const fromDate = req.body.from;
  const toDate = req.body.to;
  const startCount = req.body.start;
  const bucketSize = req.body.size;

  console.log(fromDate, toDate);
  try {
    const closedPasses = await ClosedPass.find({
      "hostelDetails.hostelName": user.hostelName,
      closingDate: {
        $gt: new Date(fromDate),
        $lt: new Date(toDate),
      },
    })
      .sort({ closingDate: 1 })
      .populate({
        path: "warden",
        select: "name",
      })
      .populate({
        path: "openedBy",
        select: "name",
      })
      .populate({
        path: "closedBy",
        select: "name",
      });
    const slicedPasses = closedPasses.slice(
      startCount,
      startCount + bucketSize
    );

    return res.status(200).json({ slicedPasses });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Server error" });
  }
};

module.exports = getPassList;
