const { Router } = require("express");

const {
  getMainPage,
  getAllPatients,
  getAllAppointments,
} = require("../controllers/university");

const router = new Router();

router.get("/", getMainPage);
router.get("/all-patients", getAllPatients);
router.get("/all-appointments", getAllAppointments);

module.exports = router;
