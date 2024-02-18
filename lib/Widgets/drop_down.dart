import 'package:agriculture_aficionado/Components/api_service.dart';
import 'package:agriculture_aficionado/Model/modelsmodel.dart';
import 'package:agriculture_aficionado/Widgets/text_widget.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({super.key});

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String currentModel = "dall-e-3";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ModelsModel>>(
      future: ApiService.getModels(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        return snapshot.data == null || snapshot.data!.isEmpty
            ? const SizedBox.shrink()
            : DropdownButton(
                items: List<DropdownMenuItem<String>>.generate(
                  snapshot.data!.length,
                  (index) => DropdownMenuItem(
                    value: snapshot.data![index].id,
                    child: TxtWidget(
                      label: snapshot.data![index].id,
                      fontsize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                dropdownColor: Colors.white,
                iconEnabledColor: Colors.black,
                value: currentModel,
                onChanged: (value) {
                  setState(
                    () {
                      currentModel = value.toString();
                    },
                  );
                },
              );
      },
    );
  }
}
