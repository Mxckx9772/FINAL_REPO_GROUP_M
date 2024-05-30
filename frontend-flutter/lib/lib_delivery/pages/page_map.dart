import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapPageDesign extends StatefulWidget {
  const MapPageDesign({super.key});

  @override
  State<MapPageDesign> createState() => _MapPageDesignState();
}

class _MapPageDesignState extends State<MapPageDesign> {
  double position = 0.5;
  double initPosition = 0.5;
  final double sensibilite = 500;
  DraggableScrollableController controleur = DraggableScrollableController();
  final Completer<GoogleMapController> _controller = Completer();
  double latitude = 0;
  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(43.635503, 3.823693),
    zoom: 10,
  );
  
  
  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;

  }


  void updateMapTheme(GoogleMapController controller){
    getJsonFileFromThemes("lib/map_style.json").then((value) => setGoogleMapStyle(value, controller));
  }

  Future<String> getJsonFileFromThemes(String path) async {
    ByteData byteData = await rootBundle.load(path);
    var liste = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return utf8.decode(liste);
  }
  setGoogleMapStyle(String style, GoogleMapController controller){
    controller.setMapStyle(style);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children : [
          GoogleMap(
            mapType: MapType.normal,
            style: """
                          [
              {
                "elementType": "geometry",
                "stylers": [
                  {
                    "color": "#f5f5f5"
                  }
                ]
              },
              {
                "elementType": "labels.icon",
                "stylers": [
                  {
                    "visibility": "off"
                  }
                ]
              },
              {
                "elementType": "labels.text.fill",
                "stylers": [
                  {
                    "color": "#616161"
                  }
                ]
              },
              {
                "featureType": "administrative.land_parcel",
                "elementType": "labels.text.fill",
                "stylers": [
                  {
                    "color": "#bdbdbd"
                  }
                ]
              },
              {
                "featureType": "landscape.man_made",
                "stylers": [
                  {
                    "color": "#e6e8eb"
                  }
                ]
              },
              {
                "featureType": "poi",
                "elementType": "geometry",
                "stylers": [
                  {
                    "color": "#eeeeee"
                  }
                ]
              },
              {
                "featureType": "poi",
                "elementType": "labels.text.fill",
                "stylers": [
                  {
                    "color": "#757575"
                  }
                ]
              },
              {
                "featureType": "poi.park",
                "elementType": "geometry",
                "stylers": [
                  {
                    "color": "#a6deb5"
                  }
                ]
              },
              {
                "featureType": "poi.park",
                "elementType": "labels.text.fill",
                "stylers": [
                  {
                    "color": "#9e9e9e"
                  }
                ]
              },
              {
                "featureType": "road",
                "elementType": "geometry",
                "stylers": [
                  {
                    "color": "#ffffff"
                  }
                ]
              },
              {
                "featureType": "road",
                "elementType": "geometry.stroke",
                "stylers": [
                  {
                    "color": "#dedede"
                  }
                ]
              },
              {
                "featureType": "road.arterial",
                "elementType": "labels.text.fill",
                "stylers": [
                  {
                    "color": "#757575"
                  }
                ]
              },
              {
                "featureType": "road.highway",
                "elementType": "geometry",
                "stylers": [
                  {
                    "color": "#93abe7"
                  }
                ]
              },
              {
                "featureType": "road.highway",
                "elementType": "geometry.stroke",
                "stylers": [
                  {
                    "color": "#65749a"
                  },
                  {
                    "visibility": "off"
                  }
                ]
              },
              {
                "featureType": "road.highway",
                "elementType": "labels.text.fill",
                "stylers": [
                  {
                    "color": "#616161"
                  }
                ]
              },
              {
                "featureType": "road.local",
                "elementType": "labels.text.fill",
                "stylers": [
                  {
                    "color": "#9e9e9e"
                  }
                ]
              },
              {
                "featureType": "transit.line",
                "elementType": "geometry",
                "stylers": [
                  {
                    "color": "#e5e5e5"
                  }
                ]
              },
              {
                "featureType": "transit.station",
                "elementType": "geometry",
                "stylers": [
                  {
                    "color": "#eeeeee"
                  }
                ]
              },
              {
                "featureType": "water",
                "elementType": "geometry",
                "stylers": [
                  {
                    "color": "#abd4f3"
                  }
                ]
              },
              {
                "featureType": "water",
                "elementType": "labels.text.fill",
                "stylers": [
                  {
                    "color": "#9e9e9e"
                  }
                ]
              }
            ]
            """,
            initialCameraPosition: kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              updateMapTheme(controller);
              _controller.complete(controller);
            },
          ),
          DraggableScrollableSheet(
            minChildSize: 0.25,
            maxChildSize: 0.75,
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
                    if (position < 0.25) {
                      position = 0.25;
                    }
                    if (position > 0.75) {
                      position = 0.75;
                    }
                    setState(() { });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: position == 0.75 
                      ? const Radius.circular(0)
                      : const Radius.circular(40),
                      topRight: position == 0.75 
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15
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
