const socketio = require('socket.io');
const jwt = require('jsonwebtoken');
const Device = require('./model/device');
const Trigger = require('./model/trigger');

let io;
const config = process.env;

const findTrigger = async (deviceId) => {
    try {
        const trigger = await Trigger.find({ from: deviceId });

        return trigger;
    } catch (error) {
        console.log(error);
    }
}

const sendToTriggers = (triggers, value) => {
    triggers.forEach(trigger => {
        io
            .of(`/${trigger.to}`)
            .emit('command', value);
    });
}

exports.setupWebsocket = (server) => {
    try {
        io = socketio(server, {
            cors: {
                origin: "*",
                methods: ["GET", "POST"],
            }
        });

        const workspaces = io.of(/^\/\w+$/);

        workspaces.use((socket, next) => {
            let token = socket.handshake.auth.token;

            console.log(socket.handshake.auth);
            console.log(socket.handshake);

            if (token) {
                jwt.verify(token, config.TOKEN_KEY, (error, decoded) => {
                    if (error) {
                        console.log("verifying");
                        return next(new Error('Authentication error'));
                    }

                    const id = decoded.params.id;

                    if ("/" + id !== socket.nsp.name) {
                        console.log("namespace");
                        return next(new Error('Authentication error'));
                    }

                    socket.authId = decoded.params.id;
                    next();
                });
            }
            else {
                console.log("error");
                next(new Error('Authentication error'));
            }
        })
            .on('connection', async (socket) => {
                const workspace = socket;

                let triggers;

                console.log('websocket connected');

                try {
                    let connectedDevice = await Device.findById(socket.authId)

                    connectedDevice.status = true;
                    await connectedDevice.save();

                    triggers = await findTrigger(socket.authId);
                } catch (error) {
                    workspace.disconnect();
                }

                workspace.on('sensor data', async (data) => {
                    try {
                        connectedDevice = await Device.findById(socket.authId)

                        connectedDevice.measurements.push({ value: data.value });
                        //await connectedDevice.save();

                        if (triggers) {
                            sendToTriggers(triggers, data.value);
                        }
                    } catch (error) {
                        console.log(error);
                    }
                });

                workspace.on('disconnect', async () => {
                    console.log("device:" + socket.id + " disconnecting");

                    try {
                        connectedDevice = await Device.findById(socket.authId)

                        connectedDevice.status = false;
                        await connectedDevice.save();

                    } catch (error) {
                        console.log(error);
                    }
                });
            }
            );
    } catch (error) {
        console.log(error);
    }
}