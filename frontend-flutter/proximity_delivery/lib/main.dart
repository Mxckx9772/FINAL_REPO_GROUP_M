import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:proximity_delivery/pages/welcome.dart';
import 'package:proximity_delivery/theme/light_theme.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
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
    );
  }
}
