import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.imageUrl, required this.isME});

  final String? sender;
  final String? text;
  final String? imageUrl;
  final bool isME;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isME ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender!,
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
          Material(
            borderRadius: isME
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isME ? Color(0xFFF5C228) : Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (text != null && text!.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0,
                    ),
                    child: Text(
                      text!,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: isME ? Colors.white : Colors.black54,
                      ),
                    ),
                  ),
                if (imageUrl != null && imageUrl!.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 5.0,
                    ),
                    child: Image.network(
                      imageUrl!,
                      width: 200.0,
                      height: 200.0,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
