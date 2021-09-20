import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// widget personalizado para um botao
// verifica qual a platafor utilizada e retorna um botao especifico

class AdaptiveButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  AdaptiveButton({required this.label, required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(label),
            onPressed: onPressed,
          )
        : ElevatedButton(
            child: Text(label),
            onPressed: onPressed,
          );
  }
}
