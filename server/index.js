const { Socket } = require("dgram");
const express = require("express");
const http = require("http");
const mongoose = require("mongoose");

const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);
const Room = require("./models/room")
var io = require("socket.io")(server);



// middleware
app.use(express.json());

const DB = "mongodb+srv://shahmeer12:qwerty12@cluster0.wj3ogac.mongodb.net/?retryWrites=true&w=majority";
server.listen(port, '0.0.0.0', () => {
    console.log('server is running on port :' + port);

})

io.on("connection", (socket) => {
    console.log("connected");
    socket.on("createRoom", async ({ nickname }) => {
        console.log(nickname);
        // Creating Room
        try {
            let room = new Room();
            let player = {
                socketId: socket.id,
                nickname,
                playerType: 'X',
            };
            room.players.push(player);
            room.turn = player;
            room = await room.save();
            const roomId = room._id.toString();
            socket.join(roomId);
            io.to(roomId).emit('Create Room Success', room)
        } catch (e) {
            console.log(e);
        };



    });
    socket.on('joinRoom', async ({ nickname, roomId }) => {
        try {
            if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
                socket.emit('Error Occured', 'Please enter a valid Room id');
                return;
            }
            let room = await Room.findById(roomId);
            if (room.isjoin) {
                let player = {
                    nickname,
                    socketId: socket.id,
                    playerType: 'O',
                }
                socket.join(roomId);
                room.players.push(player);
                room.isjoin=false; 
                room = await room.save();
                io.to(roomId).emit('JoinRoomSuccess', room);
                io.to(roomId).emit('updatePlayers', room.players);
                io.to(roomId).emit('updateRoom' , room);

            } else {
                socket.emit('ErrorOccured', 'The game is in progress try again later');
            }

        } catch (e) {
            console.log(e);
        }
    });

    socket.on('tap',async ({index,roomId})=>{
try{
let room = await Room.findById(roomId);
let choice = room.turn.playerType;
if(room.turnIndex== 0){
    room.turn = room.players[1];
    room.turnIndex =1;
}else{
    room.turn = room.players[0];
    room.turnIndex =0;
    
}
room =await room.save();
io.to(roomId).emit('tapped',{
    index,
    choice,
    room,
})
}catch(e){
    console.log(e);
}
    });

    socket.on('winner' , async({winnerSocketId,roomId})=>{
        try{
let room = await Room.findById(roomId);
room.players.find((playerr)=>playerr.socketId == winnerSocketId);
player.points+=1;
room =await room.save();

if(player.points>= room.maxRounds){
    io.to(roomId).emit("endgame", player)
}else{
    io.to(roomId).emit("pointIncrease", player);
}
        }catch(e){
            console.log(e);
        }
    })
});

mongoose.connect(DB).then(() => {
    console.log("connection is successfull");
}).catch((e) => {
    console.log(e);
});


