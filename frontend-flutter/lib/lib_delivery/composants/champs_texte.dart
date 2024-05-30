import 'package:flutter/material.dart';

class ChampsTexte extends StatefulWidget {
  final String labelText;
  final String? texteExplicatif;
  final String texteErreur;
  final RegExp attendu;
  final TextEditingController controllerTexte;

  const ChampsTexte({
    super.key, 
    required this.labelText,
    this.texteExplicatif, 
    required this.texteErreur,
    required this.attendu,
    required this.controllerTexte

  });

  @override
  State<ChampsTexte> createState() => _ChampsTexteState();
}

class _ChampsTexteState extends State<ChampsTexte> {
  final FocusNode _monFocus = FocusNode();
  TextEditingController monController = TextEditingController();

  Color couleurFocused = const Color.fromRGBO(255, 216, 20,1);
  Color couleurEnabled = const Color.fromRGBO(0, 0, 0, 0.15);
  Color? couleurHelper;
  Widget? iconEtat;
  String? textPlus;

  @override
  void initState() {
    super.initState();
    textPlus = widget.texteExplicatif;
    monController = widget.controllerTexte;
    couleurHelper = const Color.fromRGBO(0, 0, 0, 0.40);
    _monFocus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _monFocus.removeListener(_onFocusChange);
    _monFocus.dispose();
  }

  void _onFocusChange() {
    setState(() {
      if(!(_monFocus.hasFocus) && (couleurFocused == const Color.fromRGBO(255, 216, 20, 1))){
        couleurHelper = const Color.fromRGBO(0, 0, 0, 0.40);
      }else{
        couleurHelper = couleurFocused;
        if((couleurFocused == const Color.fromRGBO(76, 217, 100, 1)) && (_monFocus.hasFocus)){
          iconEtat = IconButton(
              icon: const Icon(Icons.cancel_rounded),
              color: const Color.fromRGBO(0, 0, 0, 0.40),
              onPressed: (){
                monController.clear();
                etat("");
                _onFocusChange();
              },
            );
        }else if((couleurFocused == const Color.fromRGBO(76, 217, 100, 1)) && !(_monFocus.hasFocus)){
          iconEtat = const Icon(
              Icons.check_circle_rounded,
              color: Color.fromRGBO(76, 217, 100, 1),
            );
        }
      }
    });
    
    debugPrint("Focus: ${_monFocus.hasFocus.toString()}");
  }

  void etat (String texte){
        setState(() {
          if(widget.attendu.hasMatch(texte)){
            couleurFocused = const Color.fromRGBO(76, 217, 100, 1);
            couleurEnabled = const Color.fromRGBO(76, 217, 100, 1);
            couleurHelper = couleurFocused;
            textPlus = null;
            iconEtat = const Icon(
              Icons.check_circle_rounded,
              color: Color.fromRGBO(76, 217, 100, 1),
            );
          }else if(texte.isEmpty){
            couleurFocused = const Color.fromRGBO(255, 216, 20, 1);
            couleurEnabled = const Color.fromRGBO(0, 0, 0, 0.15);
            couleurHelper = couleurFocused;
            iconEtat = null;
            textPlus = widget.texteExplicatif;
          }else{
            couleurFocused = const Color.fromRGBO(240, 51, 51, 1);
            couleurEnabled = const Color.fromRGBO(240, 51, 51, 1);
            couleurHelper = couleurFocused;
            textPlus = widget.texteErreur;
            iconEtat = IconButton(
              icon: const Icon(Icons.cancel_rounded),
              color: const Color.fromRGBO(0, 0, 0, 0.40),
              onPressed: (){
                monController.clear();
                etat("");
                _onFocusChange();
              },
            );
          }
        });
      }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        _monFocus.unfocus();
      },
      validator: (value) {
        if((widget.attendu.hasMatch("$value"))) {
          return null;
        }else{
          setState(() {
            couleurFocused = const Color.fromRGBO(240, 51, 51, 1);
            couleurEnabled = const Color.fromRGBO(240, 51, 51, 1);
            couleurHelper = couleurEnabled;
            textPlus = widget.texteErreur;
          });
          return textPlus;
        }
      },
      focusNode: _monFocus,
      controller: monController,
      onChanged: etat,
      cursorColor: couleurFocused,
      cursorErrorColor: couleurFocused,
      cursorWidth: 1,
      cursorHeight: 20,
      cursorRadius: const Radius.circular(0.5),
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Color.fromRGBO(0, 0, 0, 1)
      ),
      decoration: InputDecoration(
        label: Text(
          widget.labelText,
          style: TextStyle(
            color: couleurEnabled
          )
        ),
        helperText: textPlus,
        helperStyle: TextStyle(
          fontWeight: FontWeight.w400,
          color: couleurHelper
        ),
        errorStyle: TextStyle(
          fontWeight: FontWeight.w400,
          color: couleurHelper
        ),
        suffixIcon: iconEtat,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: couleurFocused
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: couleurFocused
          )
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: couleurEnabled
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: couleurEnabled
          )
        )
      )
    );
  }
}