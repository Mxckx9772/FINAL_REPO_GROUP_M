const Redis = require("ioredis")



////////////////////////////////////////////////////////////////////////////
const coursierQueue = new Redis();

// ajoute un coursier dans la file
async function addCoursier(city,coursier){
	await coursierQueue.rpush(`cityCoursier:${city}`,JSON.stringify(coursier));
}
// pop un coursier de la file 
async function getCoursier(city){
	const o = await  coursierQueue.rpop(`cityCoursier:${city}`);
	return JSON.parse(o);
}
// longeur de la file
async function getLenCoursier(city){
    const len = await coursierQueue.llen(`cityCoursier:${city}`)
    return len
}
// regarder un coursier dans un index sans supprimer de la file
async function getCoursierAt(city,index){
    const toremove="REMOVEIT";
    const coursier = await coursierQueue.lindex(`cityCoursier:${city}`,index);
    return JSON.parse(coursier);
}
// retourner un coursier dans un index et le supprimer de la file
async function getCoursierAtRemove(city,index){
    const toremove="REMOVEIT";
    const coursier = await coursierQueue.lindex(`cityCoursier:${city}`,index);
    
    await coursierQueue.lset(`cityCoursier:${city}`,index,toremove);
    await coursierQueue.lrem(`cityCoursier:${city}`,1,toremove);
    return JSON.parse(coursier);
}
////////////////////////////////////////////////////////////////////////////

// meme fonction mais pour la file des commandes

////////////////////////////////////////////////////////////////////////////
const client = new Redis();
client.on('error', err => console.log('Redis Client Error', err));
async function addOrder(city,order){
	await client.rpush(`city:${city}`,JSON.stringify(order));
}

async function getOrder(city){
	const o = await client.rpop(`city:${city}`);
	return JSON.parse(o);
}

async function getLen(city){
    const len = await client.llen(`city:${city}`)
    return len
}

async function getOrderAt(city,index){
    const toremove="REMOVEIT";
    const order = await client.lindex(`city:${city}`,index);
    
    //await client.lset(`city:${city}`,index,toremove);
    //await client.lrem(`city:${city}`,1,toremove);
    return JSON.parse(order);
}
async function getOrderAtRemove(city,index){
    const toremove="REMOVEIT";
    const order = await client.lindex(`city:${city}`,index);
    
    await client.lset(`city:${city}`,index,toremove);
    await client.lrem(`city:${city}`,1,toremove);
    return JSON.parse(order);
}
///////////////////////////////////////////////////////////
module.exports = {
    addOrder,
    getOrder,
    getLen,
    getOrderAt,
    getOrderAtRemove,
    addCoursier,
    getCoursier,
    getLenCoursier,
    getCoursierAt,
    getCoursierAtRemove,
    client,
    coursierQueue
}; 
