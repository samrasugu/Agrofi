import 'package:flutter/material.dart';

class CustomDisabledTextField extends StatelessWidget {
   final TextEditingController controller;
  final String hintText;
  final int maxLines;
  const CustomDisabledTextField({super.key, required this.controller, required this.hintText, required this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        controller: controller,
        enabled: false,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 14),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
        ),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return "Enter your $hintText";
          }
          return null;
        },
        maxLines: maxLines,
      ),
    );
  }
}