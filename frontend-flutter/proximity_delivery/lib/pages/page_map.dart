import 'dart:async';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:proximity_delivery/pages/bar_code_scanner_page.dart';
import 'package:proximity_delivery/pages/profil_page.dart';

class MapPageDesign extends StatefulWidget {
  const MapPageDesign({super.key});

  @override
  State<MapPageDesign> createState() => _MapPageDesignState();
}

class _MapPageDesignState extends State<MapPageDesign> {
  double position = 0.35;
  double initPosition = 0.5;
  final double sensibilite = 500;
  DraggableScrollableController controleur = DraggableScrollableController();
  final Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  double latitude = 43.610739699031626;
  double longitude = 3.876864084656635;

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(43.62505, 3.862038),
    zoom: 13,
  );

  
  @override
  void initState() {
    //addCustomIcon();
    super.initState();
  }

  /*void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/icons/MarkerGoogleMap.bmp")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }*/
  
  
  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;

  }


  /*void updateMapTheme(GoogleMapController controller){
    getJsonFileFromThemes("lib/map_style.json").then((value) => setGoogleMapStyle(value, controller));
  }

  Future<String> getJsonFileFromThemes(String path) async {
    ByteData byteData = await rootBundle.load(path);
    var liste = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return utf8.decode(liste);
  }
  setGoogleMapStyle(String style, GoogleMapController controller){
    controller.setMapStyle(style);
  }*/
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilPage())
            );
          },
          icon: const Icon(Icons.account_circle_rounded)
        ),
        centerTitle: true,
        title: const Text(
          "Commandes",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.25,
            color: Color.fromRGBO(0, 0, 0, 1)
          )
        )
      ),
      body: Stack(
        children : [
          GoogleMap(
            zoomGesturesEnabled: false,
            tiltGesturesEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              //updateMapTheme(controller);
              controller.setMapStyle(
                """
                  [
                    {
                      "featureType": "poi",
                      "stylers": [
                        {
                          "visibility": "off"
                        }
                      ]
                    }
                  ]
                """
              );
              _controller.complete(controller);
            },
            markers: {
              /*const Marker(
                markerId: MarkerId('Boutique en cours'),
                position: LatLng(43.610739699031626, 3.876864084656635),
                //icon: markerIcon,
              ),*/
          },
          ),
          DraggableScrollableSheet(
            minChildSize: 0.35,
            maxChildSize: 0.45,
            initialChildSize: position,
            controller: controleur,
            builder: (context, scrollController){
              return GestureDetector(
                onVerticalDragStart:(DragStartDetails d) {
                  setState(() {
                    initPosition = d.globalPosition.dy;
                  });
                },
                onVerticalDragUpdate: (DragUpdateDetails d) {
                  for(int i=0; i<10; i++){
                    print("${d.delta.dy}Ò");
                  }
                  position -= d.delta.dy / sensibilite;
                    if (position < 0.35) {
                      position = 0.35;
                    }
                    if (position > 0.45) {
                      position = 0.45;
                    }
                    setState(() { });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: position == 0.45 
                      ? const Radius.circular(0)
                      : const Radius.circular(40),
                      topRight: position == 0.45 
                      ? const Radius.circular(0)
                      : const Radius.circular(40),
                    ),
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromRGBO(0, 0, 0, 1).withOpacity(0.05),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 0)
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 15,
                          left: (MediaQuery.of(context).size.width-55)/2,
                        ),
                        child: Container(
                          width: 55,
                          height: 10,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(0, 0, 0, 1).withOpacity(0.10),
                            borderRadius: BorderRadius.circular(5)
                          )
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          bottom: 5,
                          left: 35, 
                          right: 35
                        ),
                        child: FlutterStepIndicator(
                          progressColor: Color.fromRGBO(255, 216, 20, 1),
                          onChange: (etat){}, 
                          list: const ["Validation", "Récupération", "Livraison"], 
                          page: 0, 
                          height: 20
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 15,
                          top: 25,
                          bottom: 10,
                        ),
                        child: Text(
                          "Commandes en attente...",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10
                        ),
                        child: Card.outlined(
                          color: Colors.green.withOpacity(0.05),//const Color.fromRGBO(255, 216, 20, .05),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const ListTile(
                                /*leading: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      color: Colors.transparent
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: const Image(image: AssetImage('assets/icons/LogoUniqlo.png'))
                                  )
                                ),*/
                                //Icon(Icons.album),
                                title: Text("Requete de commande"),
                                subtitle: Text("Commande d'une durée estimée de 30 min."),
                                //const Text("Les Halles Castellanes, Rue de l'Herberie, 34000 Montpellier"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  /*TextButton(
                                    style: const ButtonStyle(
                                      overlayColor: MaterialStatePropertyAll(Color.fromRGBO(255, 216, 20, .25))
                                    ),
                                    child: const Text(
                                      'RECUPERER',
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 216, 20, 1)
                                      ),
                                    ),
                                    onPressed: () {/* ... */},
                                  ),*/
                                  const SizedBox(width: 8),
                                  TextButton(
                                    style: ButtonStyle(
                                      overlayColor: MaterialStatePropertyAll(Colors.green.withOpacity(0.25)/*Color.fromRGBO(255, 216, 20, .25)*/)
                                    ),
                                    child: const Text(
                                      'ACCEPTER',
                                      style: TextStyle(
                                        color: Colors.green//Color.fromRGBO(255, 216, 20, 1)
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const MapPageDesign2())
                                      );
                                      /* ... */
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                            ],
                          ),
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 2,
                          bottom: 10,
                          left: 15,
                        ),
                        child: Text(
                          "* L'adresse vous sera communiquée quand vous aurez accepté.",
                          style: TextStyle(
                            color: Colors.black.withOpacity(.5),
                          ),
                        ),
                      ),
                    ],
                  )
                )
              );
            }
          ),
        ]
      )
    );
  }
}

class MapPageDesign2 extends StatefulWidget {
  const MapPageDesign2({super.key});

  @override
  State<MapPageDesign2> createState() => _MapPageDesign2State();
}

class _MapPageDesign2State extends State<MapPageDesign2> {
  double position = 0.35;
  double initPosition = 0.5;
  final double sensibilite = 500;
  DraggableScrollableController controleur = DraggableScrollableController();
  final Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  double latitude = 43.610739699031626;
  double longitude = 3.876864084656635;

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(43.610739699031626, 3.876864084656635),
    zoom: 13,
  );

  
  @override
  void initState() {
    //addCustomIcon();
    super.initState();
  }

  /*void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/icons/MarkerGoogleMap.bmp")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }*/
  
  
  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;

  }


  /*void updateMapTheme(GoogleMapController controller){
    getJsonFileFromThemes("lib/map_style.json").then((value) => setGoogleMapStyle(value, controller));
  }

  Future<String> getJsonFileFromThemes(String path) async {
    ByteData byteData = await rootBundle.load(path);
    var liste = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return utf8.decode(liste);
  }
  setGoogleMapStyle(String style, GoogleMapController controller){
    controller.setMapStyle(style);
  }*/
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children : [
          GoogleMap(
            zoomGesturesEnabled: false,
            tiltGesturesEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              //updateMapTheme(controller);
              controller.setMapStyle(
                """
                  [
                    {
                      "featureType": "poi",
                      "stylers": [
                        {
                          "visibility": "off"
                        }
                      ]
                    }
                  ]
                """
              );
              _controller.complete(controller);
            },
            markers: {
              const Marker(
                markerId: MarkerId('Boutique en cours'),
                position: LatLng(43.610739699031626, 3.876864084656635),
                //icon: markerIcon,
              ),
          },
          ),
          DraggableScrollableSheet(
            minChildSize: 0.35,
            maxChildSize: 0.45,
            initialChildSize: position,
            controller: controleur,
            builder: (context, scrollController){
              return GestureDetector(
                onVerticalDragStart:(DragStartDetails d) {
                  setState(() {
                    initPosition = d.globalPosition.dy;
                  });
                },
                onVerticalDragUpdate: (DragUpdateDetails d) {
                  for(int i=0; i<10; i++){
                    print("${d.delta.dy}Ò");
                  }
                  position -= d.delta.dy / sensibilite;
                    if (position < 0.35) {
                      position = 0.35;
                    }
                    if (position > 0.45) {
                      position = 0.45;
                    }
                    setState(() { });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: position == 0.45 
                      ? const Radius.circular(0)
                      : const Radius.circular(40),
                      topRight: position == 0.45 
                      ? const Radius.circular(0)
                      : const Radius.circular(40),
                    ),
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromRGBO(0, 0, 0, 1).withOpacity(0.05),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 0)
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 15,
                          left: (MediaQuery.of(context).size.width-55)/2,
                        ),
                        child: Container(
                          width: 55,
                          height: 10,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(0, 0, 0, 1).withOpacity(0.10),
                            borderRadius: BorderRadius.circular(5)
                          )
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          bottom: 5,
                          left: 35, 
                          right: 35
                        ),
                        child: FlutterStepIndicator(
                          progressColor: Color.fromRGBO(255, 216, 20, 1),
                          onChange: (etat){}, 
                          list: const ["Validation", "Récupération", "Livraison"], 
                          page: 1, 
                          height: 20
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 15,
                          top: 25,
                          bottom: 10,
                        ),
                        child: Text(
                          "En cours de récupération...",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10
                        ),
                        child: Card.outlined(
                          color: const Color.fromRGBO(255, 216, 20, .05),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      color: Colors.transparent
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: const Image(image: AssetImage('assets/icons/LogoUniqlo.png'))
                                  )
                                ),
                                //Icon(Icons.album),
                                title: Text("Uniqlo"),
                                subtitle: const Text("Les Halles Castellanes, Rue de l'Herberie, 34000 Montpellier"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  TextButton(
                                    style: const ButtonStyle(
                                      overlayColor: MaterialStatePropertyAll(Color.fromRGBO(255, 216, 20, .25))
                                    ),
                                    child: const Text(
                                      "COPIER ADRESSE",
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 216, 20, 1)
                                      ),
                                    ),
                                    onPressed: () async {
                                      Clipboard.setData(
                                        const ClipboardData(text:"Les Halles Castellanes, Rue de l'Herberie, 34000 Montpellier")).then((_){
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Adresse copiée dans le presse-papier.")));
                                        });
                                    }
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    style: const ButtonStyle(
                                      overlayColor: MaterialStatePropertyAll(Color.fromRGBO(255, 216, 20, .25))
                                    ),
                                    child: const Text(
                                      'SCANNER LE CODE',
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 216, 20, 1)
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const BarCodeScannerPage())
                                      );
                                      /* ... */
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                            ],
                          ),
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 2,
                          bottom: 10,
                          left: 15,
                        ),
                        child: Text(
                          "* Rendez vous à l'adresse de la boutique donnez le numéro de commande ci-dessous puis scanner le QR-code de recupération.",
                          style: TextStyle(
                            color: Colors.black.withOpacity(.5),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 2,
                          bottom: 10,
                          left: 150,
                        ),
                        child: Text(
                          "*CM_45672",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            backgroundColor: Color.fromRGBO(255, 216, 20, 1),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  )
                )
              );
            }
          ),
        ]
      )
    );
  }
}

class MapPageDesign3 extends StatefulWidget {
  const MapPageDesign3({super.key});

  @override
  State<MapPageDesign3> createState() => _MapPageDesign3State();
}

class _MapPageDesign3State extends State<MapPageDesign3> {
  double position = 0.35;
  double initPosition = 0.5;
  final double sensibilite = 500;
  DraggableScrollableController controleur = DraggableScrollableController();
  final Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  double latitude = 43.610739699031626;
  double longitude = 3.876864084656635;

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(43.610739699031626, 3.876864084656635),
    zoom: 13,
  );

  
  @override
  void initState(){
    getCallPermission();
    super.initState();
  }

  Future<void>getCallPermission() async{
    var SMSStatus = await Permission.sms.status;
    if(SMSStatus.isDenied){
      Permission.sms.request();
    }
    var PhoneStatus = await Permission.phone.status;
    if(PhoneStatus.isDenied){
      Permission.phone.request();
    }
    
  }

  /*void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/icons/MarkerGoogleMap.bmp")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }*/
  
  
  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;

  }


  /*void updateMapTheme(GoogleMapController controller){
    getJsonFileFromThemes("lib/map_style.json").then((value) => setGoogleMapStyle(value, controller));
  }

  Future<String> getJsonFileFromThemes(String path) async {
    ByteData byteData = await rootBundle.load(path);
    var liste = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return utf8.decode(liste);
  }
  setGoogleMapStyle(String style, GoogleMapController controller){
    controller.setMapStyle(style);
  }*/
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children : [
          GoogleMap(
            zoomGesturesEnabled: false,
            tiltGesturesEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              //updateMapTheme(controller);
              controller.setMapStyle(
                """
                  [
                    {
                      "featureType": "poi",
                      "stylers": [
                        {
                          "visibility": "off"
                        }
                      ]
                    }
                  ]
                """
              );
              _controller.complete(controller);
            },
            markers: {
              const Marker(
                markerId: MarkerId('Boutique en cours'),
                position: LatLng(43.610739699031626, 3.876864084656635),
                //icon: markerIcon,
              ),
          },
          ),
          DraggableScrollableSheet(
            minChildSize: 0.35,
            maxChildSize: 0.45,
            initialChildSize: position,
            controller: controleur,
            builder: (context, scrollController){
              return GestureDetector(
                onVerticalDragStart:(DragStartDetails d) {
                  setState(() {
                    initPosition = d.globalPosition.dy;
                  });
                },
                onVerticalDragUpdate: (DragUpdateDetails d) {
                  for(int i=0; i<10; i++){
                    print("${d.delta.dy}Ò");
                  }
                  position -= d.delta.dy / sensibilite;
                    if (position < 0.35) {
                      position = 0.35;
                    }
                    if (position > 0.45) {
                      position = 0.45;
                    }
                    setState(() { });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: position == 0.45 
                      ? const Radius.circular(0)
                      : const Radius.circular(40),
                      topRight: position == 0.45 
                      ? const Radius.circular(0)
                      : const Radius.circular(40),
                    ),
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromRGBO(0, 0, 0, 1).withOpacity(0.05),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 0)
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 15,
                          left: (MediaQuery.of(context).size.width-55)/2,
                        ),
                        child: Container(
                          width: 55,
                          height: 10,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(0, 0, 0, 1).withOpacity(0.10),
                            borderRadius: BorderRadius.circular(5)
                          )
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          bottom: 5,
                          left: 35, 
                          right: 35
                        ),
                        child: FlutterStepIndicator(
                          progressColor: Color.fromRGBO(255, 216, 20, 1),
                          onChange: (etat){}, 
                          list: const ["Validation", "Récupération", "Livraison"], 
                          page: 2, 
                          height: 20
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 15,
                          top: 25,
                          bottom: 10,
                        ),
                        child: Text(
                          "En cours de livraison...",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10
                        ),
                        child: Card.outlined(
                          color: const Color.fromRGBO(255, 216, 20, .05),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      color: Colors.transparent
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: const Image(
                                      image: AssetImage('assets/icons/photoProfil.png'),
                                      
                                    )
                                  )
                                ),
                                //Icon(Icons.album),
                                title: Text("Alexis"),
                                subtitle: const Text("14bis Av. Jean Jaurès, 34170 Castelnau-le-Lez"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  TextButton(
                                    style: const ButtonStyle(
                                      overlayColor: MaterialStatePropertyAll(Color.fromRGBO(255, 216, 20, .25))
                                    ),
                                    child: const Text(
                                      "COPIER ADRESSE",
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 216, 20, 1)
                                      ),
                                    ),
                                    onPressed: () async {
                                      Clipboard.setData(
                                        const ClipboardData(text:"14bis Av. Jean Jaurès, 34170 Castelnau-le-Lez")).then((_){
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Adresse copiée dans le presse-papier.")));
                                        });
                                    }
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    style: const ButtonStyle(
                                      overlayColor: MaterialStatePropertyAll(Color.fromRGBO(255, 216, 20, .25))
                                    ),
                                    child: const Text(
                                      'SCANNER LE CODE',
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 216, 20, 1)
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const BarCodeScannerPage2())
                                      );
                                      /* ... */
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                            ],
                          ),
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 2,
                          bottom: 10,
                          left: 15,
                        ),
                        child: Text(
                          "Appuyez sur le bouton ci-après pour contacter le client et scannez le code.",
                          style: TextStyle(
                            color: Colors.black.withOpacity(.5),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width-150)/2,
                        child:TextButton(
                          style: const ButtonStyle(
                            overlayColor: MaterialStatePropertyAll(Color.fromRGBO(198, 172, 40, 1)),
                            backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(255, 216, 20, 1)),
                            fixedSize: MaterialStatePropertyAll(Size(150, 45))
                          ),
                          child: const Text(
                            "CONTACTER",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                             /* const url = "tel:1234567";   
                              if (await canLaunchUrl(Uri.parse(url))) {
                                  await launchUrl(Uri.parse(url));
                              } else {
                                  throw 'Could not launch $url';
                              }  */ 
                              Clipboard.setData(
                                        const ClipboardData(text:"+330766528606")).then((_){
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Numéro copié dans le presse-papier.")));
                                        });

                          }
                      ),
                      )
                    ],
                  )
                )
              );
            }
          ),
        ]
      )
    );
  }
}