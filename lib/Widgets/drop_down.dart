import 'package:agriculture_aficionado/Components/chatting.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({super.key});

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String CurrentModel = 'Model 1';
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: getModelsItem,
      dropdownColor: Colors.white,
      iconEnabledColor: Colors.black,
      value: CurrentModel,
      onChanged: (Value) {
        setState(() {
          CurrentModel = Value.toString();
        });
      },
    );
  }
}
