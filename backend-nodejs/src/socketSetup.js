// socket.js
// NOT USED ANYMORE
const socketIO = require('socket.io');

function initializeSocket(server) {
    const io = socketIO(server);
    return io;
}

module.exports = initializeSocket;
