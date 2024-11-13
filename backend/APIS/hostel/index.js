const express = require("express");
const router = express.Router();

const getStudentDetails = require("./getStudentDetails");
const generatePass = require("./generatePass");
const deletePass = require("./deletePass");
const getPassData = require("./getPassData");
const editPass = require("./editPassData");
const getPassList = require("./getPassList");
const getAllPasses = require("./getAllPasses");

router.post("/getStudentDetails", getStudentDetails);
router.post("/generatePass", generatePass);
router.delete("/deletePass", deletePass);
router.post("/getPassData", getPassData);
router.put("/editPass", editPass);
router.get("/getPassList", getPassList);
router.post("/getAllPasses", getAllPasses);

module.exports = router;
