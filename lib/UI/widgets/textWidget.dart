import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Modifiedtext extends StatelessWidget {
  String text;
  Color? color;
  bool? bold;
  double? size;
  Modifiedtext({this.color, this.bold, this.size, required this.text});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: bold != null ? FontWeight.bold : FontWeight.normal,
        color: color ?? Colors.black,
        fontSize: size ?? 14,
      ),
    );
  }
}
