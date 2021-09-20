import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class AdaptiveTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function() onSubmit;
  final TextInputType keyboardType;

  AdaptiveTextField({
    Key? key,
    required this.label,
    required this.controller,
    required this.onSubmit,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            controller: controller,
            placeholder: label,
            onSubmitted: (_) => onSubmit(),
            keyboardType: keyboardType,
          )
        : TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
            ),
            onSubmitted: (_) => onSubmit(),
            keyboardType: keyboardType,
          );
  }
}
