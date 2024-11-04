import 'package:flutter/material.dart';

class TextFieldLoginRegister extends StatelessWidget {
  const TextFieldLoginRegister(
      {super.key,
      required this.text_controller,
      required this.text,
      required this.password,
      required this.typeNumber});

  final TextEditingController text_controller;
  final String text;
  final bool password;
  final bool typeNumber;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        style: const TextStyle(fontSize: 20),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo no puede estar vacio';
          }
          return null;
        },
        controller: text_controller,
        obscureText: password,
        keyboardType: (typeNumber) ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            hintText: text,
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red))),
      ),
    );
  }
}
