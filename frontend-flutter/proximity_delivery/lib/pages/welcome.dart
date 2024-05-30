import 'package:flutter/material.dart';
import 'package:proximity_delivery/pages/formulaire_connexion.dart';
import 'package:proximity_delivery/pages/formulaire_inscription.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        actions: 
        [
          TextButton(
            onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ConnexionFormPage()),
                );
              },
            style: const ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Color.fromRGBO(255, 216, 20, 1)),
              backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(255, 216, 20, 0.10)),
              overlayColor: MaterialStatePropertyAll(Color.fromRGBO(255, 216, 20, 0.25)),
              padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))
                )
              )
            ),
            child: const Text(
              "Connexion",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 20
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            const Padding(
              padding: EdgeInsets.only(
                bottom: 15
              ),
              child: Text(
                "Avez-vous déjà joué au Livreur ?",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 35
                ),
              )
            ),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 25,
                right: 25
              ),
              child: Text(
                "Occupez vous et augmentez vos revenus. On a besoin de vous.",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              )
            ),
            TextButton(
              
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const IdentityFormPage()),
                );
              },
              style: const ButtonStyle(
                fixedSize: MaterialStatePropertyAll(Size(400, 55)),
                foregroundColor: MaterialStatePropertyAll(Color.fromRGBO(255, 255, 255, 1)),
                backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(255, 216, 20, 1)),
                overlayColor: MaterialStatePropertyAll(Color.fromRGBO(0, 0, 0, 0.05)),
                ///*
                
                //*/
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  )
                )
              ),
              child: const Text(
                "Inscription",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15
                ),
              ),
            )
          ]
        )
      )
    );
  }
}
