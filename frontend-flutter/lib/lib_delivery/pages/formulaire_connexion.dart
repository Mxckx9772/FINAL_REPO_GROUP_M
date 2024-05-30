import 'package:flutter/material.dart';
//import 'package:proximity_delivery/composants/bouton_suivant.dart';
import 'package:proximity_delivery/composants/champs_texte.dart';
import 'package:proximity_delivery/couleurs/couleur.dart';
import 'package:proximity_delivery/pages/page_map.dart';

class ConnexionFormPage extends StatefulWidget {
  const ConnexionFormPage({super.key});

  @override
  State<ConnexionFormPage> createState() => _ConnexionFormPageState();
}

class _ConnexionFormPageState extends State<ConnexionFormPage> {
  final champsEmail = TextEditingController();
  final champsMotDePasse = TextEditingController();
  final _cleFormulaire = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blanc,
      appBar: AppBar(
        leading: const CloseButton(),
        backgroundColor: blanc,
        centerTitle: true,
        title: const Text(
          "Inscription",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.25,
            color: Color.fromRGBO(0, 0, 0, 1)
          )
        )
      ),
      body: Form(
        key: _cleFormulaire,
        child: 
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                """Contents,
de vous revoir.
                """,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                    letterSpacing: 0.5
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 55,
                  bottom: 5
                ),
                child: ChampsTexte(
                  controllerTexte: champsEmail,
                  labelText: "Adresse e-mail",
                  texteExplicatif: null,
                  texteErreur: "Entrez un e-mail valide.",
                  attendu: RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.(com|fr)$"),
                )
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                  bottom: 30,
                ),
                child: ChampsTexte(
                  controllerTexte: champsMotDePasse,
                  labelText: "Confirmation mot de passe", 
                  texteErreur: "",
                  attendu: RegExp(r"[a-zA-Z.]")
                ),
              ),
              TextButton(
            onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapPageDesign()),
                );
              },
            style: const ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Color.fromRGBO(255, 255, 255, 1)),
              backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(255, 216, 20, 1)),
              overlayColor: MaterialStatePropertyAll(Color.fromRGBO(195, 165, 16, 1)),
              padding: MaterialStatePropertyAll(
                EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 15

                )
              ),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                )
              )
            ),
            child: const Text(
              "Connexion",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20
              ),
            ),
          )
          ]
          )
        )
      )
    );
  }
}