const Coursier = require('../models/Coursier');
var CoursierService = require('../services/coursierService');

exports.registerCoursier = async (req, res) => {
	try {
		const coursier = await CoursierService.register(req.body);
		res.send(coursier);
	} catch (err) {
		res.status(500).send(err.message);
	}
};

exports.loginCoursier = async (req, res) => {
	try {
		const coursier = await CoursierService.login(req.body,res);
		res.send(coursier);
	} catch (err) {
		res.status(500).send(err.message);
	}
};










exports.getDeliveries = async (req,res) => {
	try {
		//const coursierCoord = req.body.coursierCurrentCoord;
		const orders = await CoursierService.getDeliveries(req.body);
        if (orders===false){
			return '404 not found!'
		}
		res.status(200).send(orders)


	} catch (err) {
		return err;
	}
};

exports.acceptedDelivery = async (req,res) => {
	try {
		const acceptedDelivery = await CoursierService.acceptedDelivery(req);
		res.satus(200).send(profileInfo);
	} catch (err) {
		res.status(500).send(err.message);
	}

};

exports.confirmDelivery = async (req,res) => {
	try{
		const confirmedDelivery= await CoursierService.confirmDelivery;
		res.status(200).send(confirmedDelivery);
	}
	catch (err){
		throw res.status(500).send(err.message);
	}
}
exports.cancelledDelivery = async (req,res) => {
	try{
		const cancelledDelivery= await CoursierService.cancelDelivery;
		res.status(200).send(cancelledDelivery);
	}
	catch (err){
		throw res.status(500).send(err.message);
	}
}
exports.collectDelivery = async (req,res) => {
	try{
		const collectedDelivery= await CoursierService.collectDelivery;
		res.status(200).send(collectedDelivery);
	}
	catch (err){
		throw res.status(500).send(err.message);
	}
}

exports.sendProfileInfo = async (req, res) => {
	try {
		const profileInfo = await CoursierService.sendProfileInfo(req);
		res.satus(200).send(profileInfo);
	} catch (err) {
		res.status(500).send(err.message);
	}
};

exports.updateProfileInfo = async (req, res) => {
	try {
		const newProfileInfo = await CoursierService.updateProfileInfo(req);
		res.satus(200).send(newProfileInfo);
	} catch (err) {
		res.status(500).send(err.message);
	}
};

exports.deleteCoursier = async (req, res) => {
	const coursierId=req.body.coursierId;
	try {
		const deleted = await CoursierService.deleteCoursier(coursierId);
		res.satus(200).send(deleted);
	} catch (err) {
		res.status(500).send(err.message);
	}
};