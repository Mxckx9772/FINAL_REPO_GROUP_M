import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:proximity_delivery/pages/page_map.dart';
import 'package:proximity_delivery/pages/validation_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

class BarCodeScannerPage extends StatefulWidget {
  const BarCodeScannerPage({super.key});

  @override
  State<BarCodeScannerPage> createState() => _BarCodeScannerPageState();
}

class _BarCodeScannerPageState extends State<BarCodeScannerPage> {
  late QRViewController controllerQR;
  late String code = 'Je suis le code';
  late QRView maVue;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool validate = false;


  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controllerQR.pauseCamera();
    } else if (Platform.isIOS) {
      controllerQR.resumeCamera();
    }
  }

  @override
  void initState() {
    super.initState();
    getPermission();
    maVue = QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
    );
  }

  @override
  void dispose() {
    controllerQR.dispose();
    super.dispose();
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      controllerQR = controller;
    });
    controllerQR.scannedDataStream.listen((scanData) {
      setState(() {
        code = '${scanData.code}'; 
        maVue = QRView(
          key: qrKey,
          onQRViewCreated: onQRViewCreated,
        );
        validate = true;
        reassemble();
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MapPageDesign3()),
      );
    });
  }

  void setNewView(){
    setState(() {
        maVue = QRView(
          key: qrKey,
          onQRViewCreated: onQRViewCreated,
        );
    });
  }

  Future<void> getPermission()async{
    var cameraStatus = await Permission.camera.status;
    if(cameraStatus.isDenied){
      Permission.camera.request();
    }

    var microStatus = await Permission.microphone.status;
    if(microStatus.isDenied){
      Permission.microphone.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: CloseButton(),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Scannez le code",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.25,
            color: Color.fromRGBO(0, 0, 0, 1)
          )
        )
      ),
      body : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: maVue //CameraPreview(controller),
              )
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 55,
              ),
              child: Container(
                alignment: AlignmentDirectional.center,
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                  color: validate 
                  ? const Color.fromRGBO(255, 216, 20, 1)
                  : const Color.fromRGBO(0, 0, 0, .1),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Text(
                  validate
                  ? "Code Scanné"
                  : "Scan en cours...",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: !validate
                    ? const Color.fromRGBO(0, 0, 0, 1)
                    : const Color.fromRGBO(255, 255, 255, 1)
                  ),
                ),

              )
            ),
          ]
        ,)
        
      )
    );
  }
}

class BarCodeScannerPage2 extends StatefulWidget {
  const BarCodeScannerPage2({super.key});

  @override
  State<BarCodeScannerPage2> createState() => _BarCodeScannerPage2State();
}

class _BarCodeScannerPage2State extends State<BarCodeScannerPage2> {
  late QRViewController controllerQR;
  late String code = 'Je suis le code';
  late QRView maVue;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool validate = false;


  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controllerQR.pauseCamera();
    } else if (Platform.isIOS) {
      controllerQR.resumeCamera();
    }
  }

  @override
  void initState() {
    super.initState();
    getPermission();
    maVue = QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
    );
  }

  @override
  void dispose() {
    controllerQR.dispose();
    super.dispose();
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      controllerQR = controller;
    });
    controllerQR.scannedDataStream.listen((scanData) {
      setState(() {
        code = '${scanData.code}'; 
        maVue = QRView(
          key: qrKey,
          onQRViewCreated: onQRViewCreated,
        );
        validate = true;
        reassemble();
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ValidationPage()),
      );
    });
  }

  void setNewView(){
    setState(() {
        maVue = QRView(
          key: qrKey,
          onQRViewCreated: onQRViewCreated,
        );
    });
  }

  Future<void> getPermission()async{
    var cameraStatus = await Permission.camera.status;
    if(cameraStatus.isDenied){
      Permission.camera.request();
    }

    var microStatus = await Permission.microphone.status;
    if(microStatus.isDenied){
      Permission.microphone.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: CloseButton(),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Scannez le code",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.25,
            color: Color.fromRGBO(0, 0, 0, 1)
          )
        )
      ),
      body : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: maVue //CameraPreview(controller),
              )
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 55,
              ),
              child: Container(
                alignment: AlignmentDirectional.center,
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                  color: validate 
                  ? const Color.fromRGBO(255, 216, 20, 1)
                  : const Color.fromRGBO(0, 0, 0, .1),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Text(
                  validate
                  ? "Code Scanné"
                  : "Scan en cours...",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: !validate
                    ? const Color.fromRGBO(0, 0, 0, 1)
                    : const Color.fromRGBO(255, 255, 255, 1)
                  ),
                ),

              )
            ),
          ]
        ,)
        
      )
    );
  }
}