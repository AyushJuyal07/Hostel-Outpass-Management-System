const jwt = require("jsonwebtoken");

const generateToken = (user) => {
  const token = jwt.sign(
    {
      _id: user?._id,
      eid: user?.eid,
      name: user?.name,
      role: user?.role,
      hostelName: user?.hostelName,
    },
    process.env.JWT_SECRET,
    {
      expiresIn: "30m",
    }
  );

  return token.toString();
};

module.exports = generateToken;
