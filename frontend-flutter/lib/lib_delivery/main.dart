import 'package:flutter/material.dart';
//import 'package:proximity_delivery/pages/page_map.dart';
import 'package:proximity_delivery/pages/welcome.dart';
import 'package:proximity_delivery/theme/light_theme.dart';

void main() {
  runApp(const ProximityDelivery());
}

class ProximityDelivery extends StatefulWidget {
  const ProximityDelivery({super.key});

  @override
  State<ProximityDelivery> createState() => _ProximityDeliveryState();
}

class _ProximityDeliveryState extends State<ProximityDelivery> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Proximity livreur",
      theme: proximitylightTheme,
      home: const WelcomePage()
      //home: const MapPageDesign()
    );
  }
}