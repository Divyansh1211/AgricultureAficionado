import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final String? txt;
  CategoryList({
    required this.txt,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(15),
        height: 100,
        width: 350,
        decoration: BoxDecoration(
          color: Color(0xFFADADAD),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Center(
            child: Text(
          txt!,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
