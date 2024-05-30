import 'package:flutter/material.dart';

String policeEcriture = 'Circular Std'; // Police d'écriture de l'application.

/* Theme de jour de l'application. */
final ThemeData proximitylightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: policeEcriture,
  shadowColor: const Color.fromRGBO(0, 0, 0, 0.10),

  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromRGBO(255, 216, 20, 0.5)
  ),
  //focusColor: const Color.fromRGBO(255, 216, 20, 1),
  inputDecorationTheme: InputDecorationTheme(

    /* Pour ne pas afficher le label flottant  */
    floatingLabelBehavior: FloatingLabelBehavior.never,

    /* Contour quand le champs n'est pas selectioné */

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: const OutlineInputBorder(
      gapPadding: 1,
      borderSide: BorderSide(
        color: Color.fromRGBO(0, 0, 0, .15),
        width: 1
      ),
    ),

    /* Contour quand le champs est selectioné */
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(255, 216, 20, 1),
        width: 1,
        style: BorderStyle.solid
      ),
    ),

    /* Style du label */
    labelStyle: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: Color.fromRGBO(0, 0, 0, 0.4)
    ),

    /* Style du label flottant */
    floatingLabelStyle: const TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
    )
  ),
);
