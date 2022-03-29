// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class InputControllerField extends StatelessWidget {
  final TextEditingController inputController;
  final String labelText;
   bool icon= false;
   InputControllerField({
    Key? key,required this.icon,
    required this.inputController,
    required this.labelText,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter $labelText";
        }
        return null;
      },
      decoration: InputDecoration(
        suffixIcon: Visibility(visible: icon,
          child: IconButton(icon:const Icon(Icons.edit) ,
          onPressed:(){
            inputController.text='';
          },
          
        
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.greenAccent,
            width: 5,
          ),
        ),
        hintText: labelText,
      ),
    );
  }
}
