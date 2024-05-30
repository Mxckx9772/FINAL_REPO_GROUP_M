import 'package:flutter/material.dart';
import 'package:proximity_delivery/composants/bouton_suivant.dart';
import 'package:proximity_delivery/composants/champs_texte.dart';
import 'package:proximity_delivery/couleurs/couleur.dart';
import 'package:proximity_delivery/pages/page_map.dart';

class IdentityFormPage extends StatefulWidget {
  const IdentityFormPage({super.key});

  @override
  State<IdentityFormPage> createState() => _IdentityFormPageState();
}

class _IdentityFormPageState extends State<IdentityFormPage> {
  final champsNom = TextEditingController();
  final champsPrenom = TextEditingController();
  final champsAdresse = TextEditingController();
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
                "Qui êtes-vous ?",
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
                  controllerTexte: champsNom,
                  labelText: "Nom",
                  texteExplicatif: "Votre vrai nom.",
                  texteErreur: "Entrez un nom valide.",
                  attendu: RegExp(r"^[A-Za-zÀ-ÖØ-öø-ÿ]+($|\-[A-Za-zÀ-ÖØ-öø-ÿ]+$)+")
                  //RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.(com|fr)$"),
                )
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                  bottom: 5
                ),
                child: ChampsTexte(
                  controllerTexte: champsPrenom,
                  labelText: "Prénom", 
                  texteExplicatif: "Votre vrai prénom", 
                  texteErreur: "Entrez un prénom valide",
                  attendu: RegExp(r"^[A-Za-zÀ-ÖØ-öø-ÿ]+($|\-[A-Za-zÀ-ÖØ-öø-ÿ]+$)+"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                  bottom: 30
                ),
                child: ChampsTexte(
                  controllerTexte: champsAdresse,
                  labelText: "Adresse", 
                  texteErreur: "Entrez une adresse valide.",
                  attendu: RegExp(r"^[A-Za-zÀ-ÖØ-öø-ÿ0-9 \-]+"),
                )
              ),
              BoutonSuivant(
                cleFormulaire: _cleFormulaire,
                cible: ContactFormPage(
                  nom: champsNom.text,
                  prenom: champsPrenom.text,
                  adresse: champsAdresse.text,
                ),
                fonctionAction: () {
                  if (_cleFormulaire.currentState!.validate()) {
                    _cleFormulaire.currentState!.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactFormPage(
                          nom: champsNom.text,
                          prenom: champsPrenom.text,
                          adresse: champsAdresse.text,
                        )
                      )
                    );
                  }
                }
              )
            ]
          )
        )
      )
    );
  }
}


class ContactFormPage extends StatefulWidget {
  final String nom;
  final String prenom;
  final String adresse;
  
  const ContactFormPage({
    super.key,
    required this.nom, 
    required this.prenom, 
    required this.adresse, 
  });

  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  final champsEmail = TextEditingController();
  final champsTelephone = TextEditingController();
  final _cleFormulaire = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blanc,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          color: const Color.fromRGBO(0, 0, 0, 1),
          highlightColor: const Color.fromRGBO(0, 0, 0, 0.10),
          onPressed: () => Navigator.pop(context)
        ),
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
                "Vos coordonnées.", 
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
                  texteErreur: "Entrez une adresse e-mail valide.",
                  attendu: RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9\.]+\.(com|fr)$")
                )
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                  bottom: 30,
                ),
                child: ChampsTexte(
                  controllerTexte: champsTelephone,
                  labelText: "Numero de téléphone", 
                  texteErreur: "Entrez un numéro de téléphone valide.",
                  attendu: RegExp(r"^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$")
                ),
              ),
              BoutonSuivant(
                cleFormulaire: _cleFormulaire,
                cible: const IdentityFormPage(),
                fonctionAction: () {
                  if (_cleFormulaire.currentState!.validate()) {
                    _cleFormulaire.currentState!.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPasswordFormPage(
                          nom: widget.nom,
                          prenom: widget.prenom,
                          adresse: widget.adresse,
                          email: champsEmail.text,
                          telephone: champsTelephone.text,
                        )
                      )
                    );
                  }
                }
              )
            ]
          )
        )
      )
    );
  }
}

class SignUpPasswordFormPage extends StatefulWidget {
  final String nom;
  final String prenom;
  final String adresse;
  final String email;
  final String telephone;
  
  const SignUpPasswordFormPage({
    super.key,
    required this.nom, 
    required this.prenom, 
    required this.adresse, 
    required this.email, 
    required this.telephone, 
  });

  @override
  State<SignUpPasswordFormPage> createState() => _SignUpPasswordFormPageState();
}

class _SignUpPasswordFormPageState extends State<SignUpPasswordFormPage> {
  final champsMotDePasse = TextEditingController();
  final champsConfirmation = TextEditingController();
  final _cleFormulaire = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blanc,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          color: const Color.fromRGBO(0, 0, 0, 1),
          highlightColor: const Color.fromRGBO(0, 0, 0, 0.10),
          onPressed: () => Navigator.pop(context)
        ),
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
                "Finalisons.", 
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
                  controllerTexte: champsMotDePasse,
                  labelText: "Nouveau mot de passe",
                  texteExplicatif: "Au moins 5 caractères, lettres, chiffres, symboles.",
                  texteErreur: "Entrez un mot de passe valide.",
                  attendu: RegExp(r"^[a-zA-Z.]{5}[a-zA-Z.]*$")
                )
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                  bottom: 30,
                ),
                child: ChampsTexte(
                  controllerTexte: champsConfirmation,
                  labelText: "Confirmation mot de passe", 
                  texteErreur: "Les mots de passe ne corespondent pas.",
                  attendu: RegExp(r"$champsMotDePasse.text")
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
              "Inscription",
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