const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);
const User = require('../models/User');
const Cart = require('../models/Cart');
const Product = require('../models/Product');
const Offer = require('../models/Offer');
const Store = require('../models/Store');
const Coursier = require('../models/Coursier');
const Delivery = require('../models/Delivery');
const Payment = require('../models/Payment');
const Bill = require('../models/Bill');
const Order = require('../models/Order');
const { check } = require('prettier');
const CryptoJS = require('crypto-js');
const jwt = require('jsonwebtoken');
const { default: mongoose } = require('mongoose');
const { localSendNotification } = require('./notificationsService');
const {addOrder,getOrder,getLen,getOrderAt,getOrderAtRemove,addCoursier,coursierQueue,getLenCoursier,getCoursier,getCoursierAt,getCoursierAtRemove}=require("../setupredis")
const QRCode = require('qrcode');
// maps api
const axios = require('axios');
const API_KEY = '5b3ce3597851110001cf6248663b8958e27c4b5c8d430f29fcf67615'; // Replace with your OpenRouteService API key
const ORS_ENDPOINT_DISTANCE = 'https://api.openrouteservice.org/v2/directions/driving-car/geojson';
const ORS_ENDPOINT_SEARCH = 'https://api.openrouteservice.org/geocode/search';

// fonction qui calcule une distance dans le plan

function calculDistancePlan(lat1, lon1, lat2, lon2) {
    const R = 6371; // Radius of the Earth in kilometers
    const dLat = (lat2 - lat1) * Math.PI / 180;
    const dLon = (lon2 - lon1) * Math.PI / 180;
    
    const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
              Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
              Math.sin(dLon / 2) * Math.sin(dLon / 2);
              
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    const distance = R * c;

    return distance;
}





// distance entre deux points avec l'api, startPoint/endPoint=[longitude,latitude]

async function getDistance(startPoint, endPoint) {
    try {
      // Construct the URL for the API request
      const url = 'https://api.openrouteservice.org/v2/directions/driving-car/geojson';
      
      // Define the request body
      const requestBody = {
        coordinates: [
          startPoint, // Start point [longitude, latitude]
          endPoint    // End point [longitude, latitude]
        ]
      };
  
      // Send the POST request to the API
      const response = await axios.post(url, requestBody, {
        headers: {
          'Authorization':API_KEY,
          'Content-Type': 'application/json'
        }
      });
  
      // Extract the distance from the response
      const distance = response.data.features[0].properties.segments[0].distance;
  
      return distance;
    } catch (error) {
      console.error(`Error fetching distance: ${error}`);
      if (error.response) {
        // Log the first n lines of the response data
        const responseText = JSON.stringify(error.response.data, null, 2);
        const responseLines = responseText.split('\n').slice(0, 30).join('\n');
        console.error(`Error response (first 10 lines):\n${responseLines}`);
      } else {
        console.error(`Error: ${error.message}`);
      }
    }
  }
// authentification 
exports.register = async(coursierInfo)=>{
    try {
    const random = Math.floor(Math.random() * (9999 - 1000 + 1)) + 1000;
    const {email,password,name,familyName,origin} = coursierInfo
    const exists = await User.findOne({ email: email });
    if (exists){
        throw new Error('Email already exists !');
    }
    const newCoursier = {
        email:email,
        password:password,
        name:name,
        familyName:familyName,
        origin:origin,
    }
    newUser.password = CryptoJS.AES.encrypt(newUser.password, process.env.ACCESS_TOKEN_SECRET).toString();
    const savedUser = await newUser.save();
	return savedUser
    }
    catch(err){
        throw err
    }
}

exports.login = async (coursierInfo)=>{
    try {
    const {email,password}=coursierInfo;
    let coursier = await User.findOne({ email: userInfo.email });
    if (!coursier){
        throw new Error('does not exist');
    }
    const hashedPassword = CryptoJS.AES.decrypt(coursier.password, process.env.ACCESS_TOKEN_SECRET).toString(CryptoJS.enc.Utf8);
	const inputPassword = password;
	if (hashedPassword === inputPassword) {
			const token = jwt.sign({ id: coursier._id, role: coursier.role }, process.env.ACCESS_TOKEN_SECRET, { expiresIn: '7d' });
					
			if (!coursier.isVerified) {
					return {
						success : false , 
						message : "Account not verified" , 
						data : 4
						}
			}
			return {
					success : true , 
					message : "" , 
					data : {
							token,
							user: {
								id: coursier._id,
								email: coursier.email,
								role: coursier.role,
								
							}
						}
			};
		}
    else {
					return {
						success : false , 
						message : "password is incorrect" , 
						data : 2
					};
				}
		} 
		
    
    catch( err){
        throw err
    }
}




// get orders that waits for coursier from database
// check the documentation for redis, also check ../setupredis.js file 
exports.getDeliveries = async (coursierInfo)=>{
    try{
        var count=0;
        const initialLen = await getLen(coursierInfo.city);
        console.log("initial length of queue is: ", initialLen);
        if (initialLen===0){
            // ajouter le livreur à la file d'attente du livreur
            await addCoursier(coursierInfo.city,coursierInfo);
            var notFound=true
            while(notFound){
            const o = await coursierQueue.brpoplpush(`city:${coursierInfo.city}`,`city:${coursierInfo.city}`,0);
            console.log("youpi found one")
            const orderRemoved =await getOrder(coursierInfo.city);
            const orderReturned= {
                order:orderRemoved,
                distance:await getDistance(coursierInfo.coordinates,orderRemoved.coordinates)
            }
            count+=1;
            if (orderReturned.distance<=coursierInfo.rayon){
                return {a:orderReturned,b:count};
            }
            else{
                await addOrder(coursierInfo.city,orderReturned.order);
            }
        }
    }
        var curs=0;
        var currentOrder=await getOrderAt(coursierInfo.city,curs);
        var closestIndex=0;
        var closestOrder={order:currentOrder,distance: await getDistance(coursierInfo.coordinates,currentOrder.coordinates)}
        count+=1;
        curs=curs+1;
        while(curs<await getLen(coursierInfo.city)){
            
            console.log("another oneeeeeeeeee")
            currentOrder=await getOrderAt(coursierInfo.city,curs);
            const currentDistance=await getDistance(coursierInfo.coordinates,currentOrder.coordinates);
            count+=1;
            if (currentDistance<closestOrder.distance){
                closestOrder={
                    order:currentOrder,
                    distance:currentDistance
                }
                closestIndex=curs
            }
            curs=curs+1;
        }

        console.log(closestOrder)
        if (closestOrder.distance<=coursierInfo.rayon){
            const returned = await getOrderAtRemove(coursierInfo.city,closestIndex);
            return {a:closestOrder,b:count};
        }
        
    }

catch(err){
    console.log(err)
}

}
// DO NOT USE, OLD VERSION KEPT FOR REFERENCES
exports.getDeliveriesNO = async (coursierCoord) => {
	try {
        console.log('getting deliveries for coursier that is in: ', coursierCoord );
        const latitude = coursierCoord[0];
        const longitude = coursierCoord[1];
        // coursier is available, we check the queue of his region for orders to be delivered
        // if none found we notify the coursier, when an order is added, 
		//const orders = await Order.find({waitingForCoursier:true});
        const exampleOrders=[orderExample,orderExample,orderExample,orderExample,orderExample,orderExample,orderExample,orderExample,]
		/*if (!orders || orders.length===0) {
			return false;
		}*/
        const filteredOrders =[];
        for (oe of exampleOrders){
            const plane_dist=calculDistancePlan(oe.coordinates.latitude,oe.coordinates.longitude,latitude,longitude);
            if (plane_dist<=2000){
                filteredOrders.push(oe);
            }
        }
        /* const returnedOrders = await processOrders(coursierCoord, filteredOrders);*/
		return filteredOrders;
	} catch (err) {
		throw err;
	}
};


// save a new delivery in the database
exports.acceptedDelivery = async (req) => {
    const { orderId, coursierId, distance } = req.body;
    try {
        // check if coursier already tried to deliver this order
        
        const newDelivery = new Delivery({
            orderId,
            coursierId,
            deliveryDate: new Date(),
            status: 'ongoing',
            earning:distance*2.5,
            distance:distance,
            isCollected:false,
        });
        const saveDelivery = await newDelivery.save();
        return newDelivery;
        }
        
        catch (err){
            throw err;
        }
}
// if the delivery is collected by coursier at store
exports.collectDelivery = async (req) =>{
    try {
        const collectedDelivery = await Delivery.findByIdAndUpdate(
            id,
            {isCollected:true}
        )
        return collectedDelivery;
    }
    catch (err) {
        throw err;
    }
}


exports.confirmDelivery = async (req) =>{
    const deliveryId = req.body.deliveryId;
    try {
        const confirmedDelivery = await Delivery.findByIdAndUpdate(
            deliveryId,
            {status:'confirmed'},
            {new: true, runValidators: true }
        )
        return confirmedDelivery;
    }
    catch (err) {
        throw err;
    }
}
exports.cancelDelivery = async (req) =>{
    const deliveryId = req.body.deliveryId;

    try {
        
        if (!confirmedDelivery.isCollected){
            const confirmedDelivery = await Delivery.findByIdAndUpdate(
                deliveryId,
                {status:'beingCancelled'},
                {new: true, runValidators: true }
            )
            return confirmedDelivery
        }
        else {
            const confirmedDelivery = await Delivery.findByIdAndUpdate(
                deliveryId,
                {status:'cancelled'},
                {new: true, runValidators: true }
            )
            const orderLookingForCoursier = await Order.findByIdAndUpdate(
                confirmedDelivery.orderId,
                {waitingForCoursier:true},
            )
            return confirmedDelivery;
        }
    }
    catch (err) {
        throw err;
    }
}

// envoyer un qrcode au client pour confirmer ou au vendeur pour confirmer le retour des articles
exports.sendQRcode = async (req) =>{
    try {
        const { deliveryId } = req.params;
        const qrCodeBuffer = await QRCode.toBuffer(deliveryId, { // on encode l'id de la livraison
            type: 'png',
        });
        res.setHeader('Content-Type', 'image/png');
        return qrCodeBuffer;
    }
    catch (err) {
        throw err;
    }
}

exports.verifyQRcode = async (req) => {
    try {
        const { scannedDeliveryId } = req.body; 
        const storedDeliveryId = req.session.deliveryId; 
        if (scannedDeliveryId === storedDeliveryId) {
            return {verified:true};
        }
        else {
            return {verified:false};
        }
    }
    catch (err) {
        throw err;
    }
}


// profile for coursier related functions

exports.sendProfileInfo = async (req) => {
    try {
    const profileInfo = await Coursier.find({coursierId:req.body.coursierId});
    return profileInfo;
    }
    catch (err) {
        throw err;
    }
}

exports.updateProfileInfo = async (req) => {
    try {
    const id=Number(req.params.coursierId);
    const newProfileInfo=req.body.newProfileInfo;
    const updatedCoursier = await Coursier.findByIdAndUpdate(
        id,
        { profileInfo: newProfileInfo },
        { new: true, runValidators: true }
    );
    return newProfileInfo;
    }
    catch (err){
        throw err;
    }
}


exports.deleteCoursier = async (coursierId) => {
    try {
    const deletedCoursier = await Coursier.findByIdAndDelete(coursierId);
    if (!deletedCoursier){
        throw new Error("coursier does not exist!");
    }
    return deletedCoursier;
    }
    catch (err) {
        throw err;
    }
}