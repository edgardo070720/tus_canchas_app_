
import 'package:flutter/material.dart';

class TextFieldSeveBusiness extends StatelessWidget {
  const TextFieldSeveBusiness(
      {super.key,
      required this.textControllers,
      required this.text,
      required this.typeKeyboard,
      required this.maxLine});
  final TextEditingController textControllers;
  final String text;
  final bool typeKeyboard;
  final int maxLine;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: textControllers,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo no puede estar vacio';
          }
          return null;
        },
        maxLines: maxLine,
        keyboardType:
            (typeKeyboard) ? TextInputType.number : TextInputType.text,
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
