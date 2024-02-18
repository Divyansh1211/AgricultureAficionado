import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TxtWidget extends StatelessWidget {
  TxtWidget(
      {required this.label, this.color, this.fontsize = 18, this.fontWeight});
  String label;
  Color? color;
  double fontsize;
  FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
          color: color ?? Colors.white,
          fontSize: fontsize,
          fontWeight: fontWeight ?? FontWeight.w500),
    );
  }
}
