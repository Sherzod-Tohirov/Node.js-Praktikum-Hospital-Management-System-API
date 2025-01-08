const pool = require("../db/config");

class University {
  constructor(id) {
    this.id = id;
  }

  async getAllPatients() {
    try {
      const result = await pool.query("SELECT * from patients");
      return result.rows;
    } catch (error) {
      console.log(error);
    }
  }

  async getAllAppointments() {
    try {
      const result = await pool.query("SELECT * from appointments");
      return result.rows;
    } catch (error) {
      console.log(error);
    }
  }
}

module.exports = University;
