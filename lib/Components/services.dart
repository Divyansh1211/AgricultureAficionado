import 'package:agriculture_aficionado/Widgets/drop_down.dart';
import 'package:agriculture_aficionado/Widgets/text_widget.dart';
import 'package:flutter/material.dart';

class Services {
  static Future<void> showModelScreen(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: TxtWidget(
                label: 'Model Chosen:',
                color: Colors.black,
                fontsize: 16,
              ),
            ),
            Flexible(
              flex: 2,
              child: DropDownWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
