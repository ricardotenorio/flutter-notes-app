const jwt = require('jsonwebtoken');
require('dotenv').config();

module.exports = {
    async createToken(params = {}) {
        return jwt.sign(
            { params },
            process.env.TOKEN_KEY,
        );
    },
}