const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

const UserSchema = new mongoose.Schema(
    {
        username: { 
            type: String,
            required: true, 
            minlength: 6,
            maxlength: 32,
            trim: true,
        },
        email: { 
            type: String, 
            required: true,
            lowercase: true,
            unique: true,
            trim: true,
            match: [
                /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/, 
                'Please fill a valid email address'
            ]
        },
        password: { 
            type: String,
            required: true,
            select: false, 
        },
        token: { 
            type: String,
        },
    }
);

UserSchema.pre('save', async function(next) {
    const hash = await bcrypt.hash(this.password, 10);
    this.password = hash;

    next();
});

module.exports = mongoose.model('User', UserSchema);