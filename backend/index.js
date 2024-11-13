require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const connectToMongoDB = require("./db/connect");
const bodyParser = require("body-parser");
const cors = require("cors");
const morgan = require("morgan");

const authRoutes = require("./APIS/auth/index");
const hostelRoutes = require("./APIS/hostel/index");
const guardRoutes = require("./APIS/guard/index");

const authorizationMiddleware = require("./middleware/authorization");
const wardenCheck = require("./middleware/wardenCheck");
const guardCheck = require("./middleware/guardCheck");

const hit = require("./hit");

connectToMongoDB();
const router = express.Router();

const app = express();
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(morgan("dev"));
app.use(router);
app.use(cors());

router.get("/hit", hit); //it is just for manually adding data in the database
router.use("/auth", authRoutes);
router.use("/hostel", authorizationMiddleware, wardenCheck, hostelRoutes);
router.use("/guard", authorizationMiddleware, guardCheck, guardRoutes);

app.listen(4000, "0.0.0.0", () =>
  console.log("The server is started in port 4000")
);
