import 'package:flutter/material.dart';

class Modifiedtextfield extends StatelessWidget {
  String text;
  IconData? icon;
  TextEditingController? controller;
  Modifiedtextfield({required this.text, this.icon, this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: controller != null ? controller : null,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                width: 0.1,
              )),
          filled: true,
          fillColor: Colors.white,
          label: Text(text),
          suffixIcon: icon != null ? Icon(icon) : null,
        ),
      ),
    );
  }
}
