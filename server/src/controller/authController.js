const User = require('../model/user');
const bcrypt = require('bcryptjs');
const { createToken } = require('../util/jwtToken');

module.exports = {
    async register(request, response) {
        const { email } = request.body;

        try {
            const existingUser = await User.findOne({ email });

            if (existingUser)
                return response.sendStatus(409);

            const user = await User.create(request.body);

            user.token = await createToken({ id: user.id });
            user.password = undefined;

            return response.status(201).json(user);
        } catch (error) {
            console.log(error);
            return response.sendStatus(500);
        }
    },

    async login(request, response) {
        try {
            const { email, password } = request.body;

            if (!(email && password)) {
                return response.sendStatus(400);
            }

            const user = await User.findOne({ email }).select('+password');

            if (!user || !(await bcrypt.compare(password, user.password))) {
                return response.sendStatus(401);
            }

            user.token = await createToken({ id: user.id });
            user.password = undefined;

            return response.status(200).json(user);
        } catch (error) {
            console.log(error);
            return response.sendStatus(500);
        }
    },
}