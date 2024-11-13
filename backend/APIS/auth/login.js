const bcrypt = require("bcrypt");
const Profile = require("../../db/models/Profile");
const generateToken = require("../../utils/generateToken");

const login = async (req, res) => {
  const { eid, password } = req.body;

  try {
    const user = await Profile.findOne({ eid });

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    const isPasswordValid = await bcrypt.compare(password, user.password);

    if (!isPasswordValid) {
      return res.status(401).json({ message: "Invalid password" });
    } else {
      res.status(200).json({
        user: {
          _id: user._id,
          eid: user.eid,
          name: user.name,
          role: user.role,
        },
        accessToken: generateToken(user),
      });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server error" });
  }
};

module.exports = login;
