const express = require("express");
const login = require("./login"); // Assuming loginHandler.js is located in the root directory

const router = express.Router();

router.post("/login", login);

module.exports = router;
