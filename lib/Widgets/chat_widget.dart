import 'package:agriculture_aficionado/Widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.msg, required this.chatIndex});

  final String msg;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: chatIndex == 0 ? Colors.grey.shade300 : Colors.white,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                chatIndex == 0 ? 'images/user.png' : 'images/AI_image.png',
                height: 30,
                width: 30,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TxtWidget(
                  label: msg,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
