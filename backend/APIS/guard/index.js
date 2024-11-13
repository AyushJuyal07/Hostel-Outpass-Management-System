const express = require("express");
const router = express.Router();

const getGeneratedPass = require("./getGeneratedPass")
const verifypass = require("./verifyPass")

router.post("/getGeneratedPass", getGeneratedPass)
router.post("/verifyPass", verifypass)

module.exports = router;
