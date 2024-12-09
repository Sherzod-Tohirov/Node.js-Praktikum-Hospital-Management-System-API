const Hospital = require("../models/hospital");
const hospital = new Hospital();

async function getAllPatients(_, res) {
  const allPatients = await hospital.getAllPatients();
  res.send(allPatients);
}

async function getAllAppointments(_, res) {
  const allAppointments = await hospital.getAllAppointments();
  res.send(allAppointments);
}

function getMainPage(_, res) {
  res.send("<h1>Hospital home page</h1>");
}

module.exports = {
  getMainPage,
  getAllPatients,
  getAllAppointments,
};
