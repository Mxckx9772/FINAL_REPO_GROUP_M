import 'package:flutter/material.dart';

class CloseButton extends StatefulWidget {
  const CloseButton({super.key});

  @override
  State<CloseButton> createState() => _CloseButtonState();
}

class _CloseButtonState extends State<CloseButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
          icon: const Icon(Icons.close_rounded),
          color: const Color.fromRGBO(0, 0, 0, 1),
          highlightColor: const Color.fromRGBO(0, 0, 0, 0.10),
          onPressed: () => Navigator.pop(context)
    );
  }
}