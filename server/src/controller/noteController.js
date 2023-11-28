const { default: mongoose } = require('mongoose');
const Note = require('../model/note');

module.exports = {
    async index(request, response) {
        try {
            const notes = await Note.find();

            notes.forEach(note => {
                note.__v = undefined;
                note.updatedAt = undefined;
            });

            return response.status(200).send({ notes });
        } catch (error) {
            return response.status(500).send({ message: error.message });
        }
    },

    async show(request, response) {
        try {
            const note = await Note.findOne({ _id: request.params.id });

            note.__v = undefined;
            note.updatedAt = undefined;

            return response.status(200).send({ note });            
        } catch (error) {
            return response.status(500).send({ message: error.message });
        }
    },

    async store(request, response) {
        try {

            const note = await Note.create({ ...request.body });

            return response.status(201).send({ note });
        } catch (error) {
            console.log(error);
            return response.status(500).send({ message: error.message });
        }
    },
    
    async update(request, response) {
        try {
            const note = await Note.findByIdAndUpdate(request.params.id, { ...request.body});

            return response.status(201).send({ note });
        } catch (error) {
            console.log(error);
            return response.status(500).send({ message: error.message });
        }
    },

    async destroy(request, response) {
        try {
            const note = await Note.findOneAndDelete({ _id: request.params.id });

            return response.status(200).send({ note });            
        } catch (error) {
            return response.status(500).send({ message: error.message });
        }
    },
}
