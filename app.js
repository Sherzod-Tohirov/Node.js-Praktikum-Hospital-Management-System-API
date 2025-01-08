const express = require("express");

const app = express();

const PORT = 3000;

const universityRoutes = require("./routes/university");

app.use(express.urlencoded({ extended: false }));
app.use("/", universityRoutes);

app.listen(PORT, () => {
  console.log(`Server is listening on ${PORT}`);
});
