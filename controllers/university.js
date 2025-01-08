const University = require("../models/university");
const university = new University();

async function getAllPatients(_, res) {
  const allPatients = await university.getAllPatients();
  res.send(allPatients);
}

async function getAllAppointments(_, res) {
  const allAppointments = await university.getAllAppointments();
  res.send(allAppointments);
}

function getMainPage(_, res) {
  res.send("<h1>University home page</h1>");
}

module.exports = {
  getMainPage,
  getAllPatients,
  getAllAppointments,
};
