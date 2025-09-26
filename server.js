const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;

app.get('/health', (req, res) => {
  res.send('OK');
});

app.get('/', (req, res) => {
  res.send('Hello from Jenkins Docker pipeline!');
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
