import 'package:flutter/material.dart';
import 'package:proximity_delivery/couleurs/couleur.dart';

class BoutonSuivant extends StatefulWidget {
  final GlobalKey<FormState> cleFormulaire;
  final Widget cible;
  final Function()? fonctionAction;

  const BoutonSuivant({
    super.key,
    required this.cleFormulaire,
    required this.cible,
    required this.fonctionAction
  });

  @override
  State<BoutonSuivant> createState() => _BoutonSuivantState();
}

class _BoutonSuivantState extends State<BoutonSuivant> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: widget.fonctionAction, 
      /*() {
        if (widget.cleFormulaire.currentState!.validate()) {
          widget.cleFormulaire.currentState!.save();

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget.cible),
        );
          /*
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Processing Data')),
          );
          */
        }
      },*/
      tooltip: null,
      splashColor: const Color.fromARGB(255, 224, 189, 19),
      backgroundColor: const Color.fromRGBO(255, 216, 20, 1),
      foregroundColor: blanc,
      elevation: 0,
      shape:  const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(1000))
      ),
      child: const Icon(Icons.arrow_forward_rounded)
      
    );
  }

}