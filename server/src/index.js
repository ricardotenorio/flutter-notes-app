require('dotenv').config();
require('./config/database').connect();
const express = require('express');
const cors = require('cors');
const http = require('http');
const routes = require('./routes');

const { API_PORT } = process.env || 3000;
const app = express();
const server = http.Server(app);
const port = process.env.PORT || API_PORT;

app.use(cors());
app.use(express.json());
app.use(express.urlencoded());
app.use(routes);

server.listen(port, () => 
    {
        console.log(`Server started at port ${port}`);
    }
);