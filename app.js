const express = require("express");

const app = express();

const PORT = 3000;

const hospitalRoutes = require("./routes/hospital");

app.use(express.urlencoded({ extended: false }));
app.use("/", hospitalRoutes);

app.listen(PORT, () => {
  console.log(`Server is listening on ${PORT}`);
});
