import 'package:flutter/material.dart';
import 'package:proximity_delivery/pages/page_map.dart';

class ValidationPage extends StatefulWidget {
  const ValidationPage({super.key});

  @override
  State<ValidationPage> createState() => _ValidationPageState();
}

class _ValidationPageState extends State<ValidationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MapPageDesign())
            );
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Validation",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.25,
            color: Color.fromRGBO(0, 0, 0, 1)
          )
        )
      ),
      body: const Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 40,
          ),
          Padding(
              padding: EdgeInsets.only(
                top: 15
              ),
              child: Text(
                "Commande validée !",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color:Color.fromRGBO(0, 0, 0, 1)
                )
              ),
            ),
        ],
      ),
      )
    );
  }
}