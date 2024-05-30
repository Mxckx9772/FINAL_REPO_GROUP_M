const axios = require('axios');
const router = require('express').Router();
var UserController = require('../controllers/userController');
const { verifyToken, verifyAdmin, verifyTokenAndAutherization } = require('../middleware/verifyToken');
const { updateSchemaValidation } = require('../middleware/dataValidation');
const io = require('../index');
//////

//update user
router.put('/:id', verifyTokenAndAutherization, updateSchemaValidation, UserController.updateUser);
//update user image
router.put('/update_image/:id', verifyTokenAndAutherization,  UserController.updateUserImage);
//delete
router.delete('/:id', verifyTokenAndAutherization, UserController.deleteUser);
//get
router.get('/', verifyAdmin, UserController.getUsers);

//get user by his id
router.get('/find/:id', verifyTokenAndAutherization, UserController.getUser);

router.get('/welcome/:id', verifyTokenAndAutherization , UserController.welcome);

// testing something DELETE IF YOU FIND IT (elmedjadji rayane -rayaneelmedjadji132@gmail.com)



module.exports = router;
