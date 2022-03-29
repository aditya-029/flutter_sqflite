// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class InputControllerField extends StatefulWidget {
  final TextEditingController inputController;
  final String labelText;
  bool icon = false;
  InputControllerField({
    Key? key,
    required this.icon,
    required this.inputController,
    required this.labelText,
  }) : super(key: key);

  @override
  State<InputControllerField> createState() => _InputControllerFieldState();
}

class _InputControllerFieldState extends State<InputControllerField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.icon,
      controller: widget.inputController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter ${widget.labelText}";
        }
        return null;
      },
      decoration: InputDecoration(
        suffixIcon: Visibility(
          visible: widget.icon,
          child: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              setState(() {
                widget.icon = false;
              });
            },
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.greenAccent,
            width: 5,
          ),
        ),
        hintText: widget.labelText,
      ),
    );
  }
}
