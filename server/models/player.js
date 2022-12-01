const mongoose = require('mongoose');
const playerschema = new mongoose.Schema({
    nickname: {
        type: String,
        trim: true,
    },
    socketId: {
        type: String,
    },
    points: {
        type: Number,
        default: 0
    },
    playerType:{
        type:String,
        required: true
    }
})

module.exports=playerschema;