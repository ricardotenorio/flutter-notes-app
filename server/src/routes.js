const { Router } = require('express');
const noteController = require('./controller/noteController');

const routes = Router();

// routes.post('/register', authController.register);
// routes.post('/login', authController.login);

routes.get('/notes', noteController.index);
routes.post('/notes', noteController.store);
routes.put('/notes/:id', noteController.update);
routes.get('/notes/:id', noteController.show);
routes.delete('/notes/:id', noteController.destroy);
routes.get('/', (req, res) => {
    console.log('working');
    res.status(200).send({ message: 'ok' });
})

module.exports = routes;
