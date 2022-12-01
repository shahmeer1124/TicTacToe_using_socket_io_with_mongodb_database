const mongoose = require('mongoose');
const playerschema = require('./player');
const roomSchema = new mongoose.Schema({
    occupancy: {
        type: Number,
        default: 2,
    },
    maxRounds: {
        type: Number,
        default: 6,
    },
    currentRound: {
        required: 2,
        type: Number,
        default: 1,
    },
    players: [playerschema],
    isjoin:{
        type:Boolean,
        default:true,
    },
    turn:playerschema,
    turnIndex:{
        type:Number,
        default:0,
    }
});

const roomModel= mongoose.model('Room' ,roomSchema );
module.exports=roomModel;