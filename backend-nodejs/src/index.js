const express = require('express');
const app = express();
const http = require('http');
const server = require("http").createServer(app);

const initializeSocket = require('./socketSetup');
const io = initializeSocket(server);
module.exports = io;
const {addOrder,getOrder}=require('./setupredis')
console.log(addOrder)

/*
const {promisify} = require("util")
// redis setup
console.log("create redis client")
const redisClient=redis.createClient();
await redisClient.connect();
console.log("end create and start promisify")
const lpushAsync = promisify(redisClient.lPush).bind(redisClient);
const lpopAsync = promisify(redisClient.lPop).bind(redisClient);
console.log(lpushAsync instanceof promisify)
const addOrder = async (city,order)=>{
	const adding = await lpushAsync(`city:${city}`,JSON.stringify(order))
};
const getOrder =async (city)=>{
	const order = await lpopAsync(`city:${city}`);
	return order;
};
const adding = addOrder('Montpellier',{id:1,article:"hello"});
const order = getOrder('Montpellier');
console.log(order)*/
const dotenv = require('dotenv');
const NODE_ENV = process.env.NODE_ENV || 'development';
dotenv.config({ path: `.env.${NODE_ENV}` });

const mongoose = require('mongoose');
const morgan = require('morgan');
const bodyParser = require('body-parser');
const { json } = require('body-parser');
const path = require('path');
const fileUpload = require('express-fileupload');
const flash = require('connect-flash');
const helmet = require('helmet');



//routes

const userRoute = require('./routes/userRoute');
const authRoute = require('./routes/authRoute');
const storeRoute = require('./routes/storeRoute');
const productRoute = require('./routes/productRoute');
const cartRoute = require('./routes/cartRoute');
const offerRoute = require('./routes/offerRoute');
const categoryRoute = require('./routes/categoryRoute');
const orderRoute = require('./routes/orderRoute');
const searchRoute = require('./routes/searchRoute');
const viewRoute = require('./routes/viewRoute');
const resetPasswordRoute = require('./routes/resetPasswordRoute');
const notificationRoute = require('./routes/notificationRoute');
const storeCategoryRoute = require('./routes/storeCategoryRoute');
const coursierRoute = require('./routes/coursierRoute');
//const adminRoute = require('./routes/admin');*/
app.use(helmet());
app.use(fileUpload());
app.use(express.json());

/////////

app.use(express.static('public'));
app.use('/api/user', userRoute);
app.use('/api/auth', authRoute);
app.use('/api/store', storeRoute);
app.use('/api/product', productRoute);
app.use('/api/cart', cartRoute);
app.use('/api/offer', offerRoute);
app.use('/api/category', categoryRoute);
app.use('/api/order', orderRoute);
app.use('/api/search', searchRoute);
app.use('/api/password-reset', resetPasswordRoute);
app.use('/api/notification', notificationRoute);
app.use('/api/view', viewRoute);
app.use('/api/storeCategory', storeCategoryRoute);
//app.use('/api/coursier',coursierRoute);



mongoose
	.connect(process.env.MONGO_URL)
	.then(() => {
		console.log('DB Conntected');
		server.listen(process.env.PORT || 5000, () => {
			console.log('backend Running');
		});
	})
	.catch((err) => {
		console.log(err);
	});
