import 'package:flutter/material.dart';

class Utils {
  static mybutton({required BuildContext context}) {
    return ElevatedButton.styleFrom(
        minimumSize: Size(MediaQuery.of(context).size.width / 2.5,
            MediaQuery.of(context).size.height / 10));
  }
}
