const express = require('express');
const router = express.Router();

const io = require('../index');

var coursierController = require('../controllers/coursierController');
// authentification for coursier
router.post('/register',coursierController.registerCoursier);
router.post('/login',coursierController.loginCoursier)

// profile page for coursier


router.get('/profile',coursierController.sendProfileInfo);
router.put('/profile',coursierController.updateProfileInfo);
router.delete('/profile',coursierController.deleteCoursier);


// deliveries 
router.get('/deliveries',coursierController.getDeliveries);
router.put('/acceptedDelivery',coursierController.acceptedDelivery);
router.put('/confirmedDelivery',coursierController.confirmDelivery);
router.delete('/cancelledDelivery',coursierController.cancelledDelivery);
router.put('/collectedDelivery',coursierController.collectDelivery);

//////////////////////////////////

// sockets

//////////////////////////////////



// testing something please delete this if you find it 
/*
router.post('/testReceiveFromClient',async (req,res)=>{
  try {
    const listening=3;
    while(listening>0){
    
    res.status(200).send(req.body.message);
  listening = listening +1;}
  }
  catch (err){
res.status(500).send("erreur from server!")
}
})

// using sockets
// 


const waitForCustomEvent= async (socket,event) =>{
  console.log(event)
  return new Promise((resolve, reject) => {
    // Listen for the custom event
    socket.on(event, data => {
      // Resolve the promise when the event is received
      resolve(data);
    });
  });
}


// Handle connection event
// Assuming `io` is already initialized

// List to keep track of available couriers
let availableCouriers = new Set();
let deliveries = new Set();
let clientSocks = new Set();
// Event handler for courier availability
io.on('connection', socket => {
  console.log('Courier connected');

  // Mark the courier as available
  availableCouriers.add(socket);

  // Listen for availability status changes
  socket.on('availability', status => {
    if (status === 'yes') {
      // Mark the courier as available
      availableCouriers.add(socket);
      console.log('Courier is now available');
      if (deliveries.size !==0){
        console.log(deliveries)
        let delivery=deliveries[0];
        socket.emit('deliveryRequest', 'There is a delivery near you. Do you accept?');
        let clientSocket = Array.from(clientSocks)[0];
        console.log(clientSocket)
          // Listen for courier response
          socket.on('responseDelivery', response => {
            if (response === 'yes') {
              // Mark the courier as unavailable
              availableCouriers.delete(socket);
              console.log('Courier accepted the delivery');
              clientSocket.emit('requestDelivery',"the courier accepted your delivery is on the way");
              console.log("sent message to client")
            } else {
              console.log('Courier declined the delivery');
            }
          });

      }
      else{
        console.log("no delivery is waiting")
      }
    } else if (status === 'unavailable') {
      // Mark the courier as unavailable
      availableCouriers.delete(socket);
      console.log('Courier is now unavailable');
    }
  });

  // Listen for disconnection to mark courier as unavailable
  socket.on('disconnect', () => {
    console.log('Courier disconnected');
    availableCouriers.delete(socket);
  });
});
// deliveries
// deliveries
io.on('connection', clientSocket => {
  console.log('Courier connected');

  // Mark the courier as available
 

  // Listen for availability status changes
  clientSocket.on('newClient', () => {
      clientSocks.add(clientSocket);
      //availableCouriers.add(socket);
      console.log('new client is here');
      clientSocket.on('requestDelivery', () => {
        // Find an available courier
        deliveries.add(42069);
         // Pick the first available courier
        console.log("a delivery is requested")
        if (availableCouriers.size!==0) {
          const courier = Array.from(availableCouriers)[0];
          console.log("courier found")
          // Send delivery request to the courier
          courier.emit('deliveryRequest', 'There is a delivery near you. Do you accept?');
    
          // Listen for courier response
          courier.on('responseDelivery', response => {
            if (response === 'yes') {
              // Mark the courier as unavailable
              availableCouriers.delete(courier);
              console.log('Courier accepted the delivery');
              clientSocket.emit('requestDelivery',"the courier accepted your delivery is on the way");
              console.log("sent message to client")
            } else {
              console.log('Courier declined the delivery');
            }
          });
        } else {
          console.log('No available couriers');
          clientSocket.emit('requestDelivery','pas de livreur, attendez');
      
        }
      });
  });

  // Listen for disconnection to mark courier as unavailable
  clientSocket.on('disconnect', () => {
    console.log('Client disconnected');
    availableCouriers.delete(clientSocket);
  });
});

/* Event handler for sending delivery requests
io.on('connection', socket => {
  console.log('Client connected');

  // Listen for delivery requests
  socket.on('requestDelivery', () => {
    // Find an available courier
    const courier = [...availableCouriers][0]; // Pick the first available courier

    if (courier) {
      // Send delivery request to the courier
      courier.emit('deliveryRequest', 'There is a delivery near you. Do you accept?');

      // Listen for courier response
      courier.on('responseDelivery', response => {
        if (response === 'yes') {
          // Mark the courier as unavailable
          availableCouriers.delete(courier);
          console.log('Courier accepted the delivery');
          socket.emit("the courier accepted your delivery is on the way")
        } else {
          console.log('Courier declined the delivery');
        }
      });
    } else {
      console.log('No available couriers');
    }
  });
});




  /* TEST A NEW ALGORITHM
  let cal=[];
  let i=0;
io.on('connection',(socket)=>{
  socket.on('coursierAvailable',(s)=>{
  console.log("un coursier est disponible");
  let available=8;
  console.log(i);
  while(available>0){
    
   socket.on("sendToCoursier",(data)=>{
      console.log("un client a passé une commande et demande un livreur");

      // on voit si la distance est respectée avec une api
      socket.emit('getDelivery',"je t'enovoi cette commande");
      
      socket.on('getDelivery',(data)=>{
        if (data.accepted===true){
          console.log("livreur accepte la commande");
          
        }
        else {
          console.log("livreur refuse la commande");
        }
      })
    })
    
  }
})
});








  // END TEST OF NEW ALGORITHM
  /*
io.on('connection', (socket)  => {
	console.log('A client connected.');


	socket.on('requestDeliveries',async (data)=>{
        const dataJson = JSON.parse(data);
		const deliveries = await coursierController.getDeliveries(dataJson.coursierCoord);
      
        io.emit("requestDeliveries",deliveries);
	});
    socket.on('acceptDelivery',(data)=>{

        // ici on demande au service de faire les changements de bdd 

        //coursierController.acceptDelivery

        

        const dataJson = JSON.parse(data);
        socket.broadcast.emit('acceptDelivery',(dataJson.deliveryId));
        
    })
    socket.on('cancelDelivery',(data)=>{

        // ici on demande au service de faire les changements de bdd //

         // coursierController.cancelDelivery

        

        const dataJson = JSON.parse(data);
        socket.broadcast.emit('cancelDelivery',(dataJson.deliveryId));
        socket.emit('cancelDelivery',"you cancelled a delivery",dataJson.deliveryId);
        
    })
	socket.on('disconnect', () => {
	  console.log('A client disconnected.');
	});
  });
*/
module.exports = router;