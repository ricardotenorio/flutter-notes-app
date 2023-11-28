const mongoose = require('mongoose');

const NoteSchema = new mongoose.Schema(
    {
        title: { 
            type: String,
            required: true, 
            minlength: 2,
            maxlength: 32,
            trim: true,
        },
        description: {
            type: String,
            maxlength: 256,
            trim: true,
        },
        color: {
            type: String,
            trim: true,
        },
        priority: {
            type: Number,
        },
        isActive: {
            type: Number,
        },
        tags: {
            type: String,
        },
    },
    {
        timestamps: true,
    }
);

NoteSchema.pre('findOneAndUpdate', function(next) {
    this.options.runValidators = true;
    next();
});

module.exports = mongoose.model('Note', NoteSchema);
