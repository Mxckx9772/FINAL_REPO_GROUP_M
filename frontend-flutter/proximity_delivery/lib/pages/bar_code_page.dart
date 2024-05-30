import 'package:flutter/material.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BarCodePage extends StatefulWidget {
  final String texte;
  const BarCodePage({
    super.key,
    required this.texte,
  });
  

  @override
  State<BarCodePage> createState() => _BarCodePageState();
}

class _BarCodePageState extends State<BarCodePage> {
  Barcode code = Barcode.fromType(BarcodeType.QrCode);
  String? svg;

  @override
  void initState() {
    svg = code.toSvg(
    "flutter.fr",
    width: 500,
    height: 500,
    fontHeight: 15,
  );
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.string(
          svg!,
          width: 300,
          height: 300,
        )
      ),
    );
  }
}
