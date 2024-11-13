const Students = require("../../db/models/Student");

const getStudentDetails = async (req, res) => {
  const uid = req.body.uid.toUpperCase();

  try {
    const student = await Students.findOne({ uid });
    if (!student) return res.status(404).json({ message: "Student not found" });
    if (student.hostelDetails?.hostelName != req.user.hostelName)
      return res
        .status(403)
        .json({ message: `Student is from ${student.hostelDetails.hostelName} hostel` });
    else
      res.status(200).json({
        name: student.name,
        uid: student.uid,
        mobileNo: student.mobileNo,
        guardianNo: student.guardianNo,
        hostelDetails: {
          hostelName: student.hostelDetails?.hostelName,
          roomNo: student.hostelDetails?.roomNo,
        },
      });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Server error" });
  }
};

module.exports = getStudentDetails;
