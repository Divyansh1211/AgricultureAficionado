import 'package:agriculture_aficionado/Components/api_service.dart';
import 'package:agriculture_aficionado/Components/services.dart';
import 'package:agriculture_aficionado/Widgets/chat_widget.dart';
import 'package:agriculture_aficionado/Widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:agriculture_aficionado/Components/chatting.dart';

class Analysis extends StatefulWidget {
  static const String id = 'Analysis';

  const Analysis({super.key});
  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  bool isTyping = true;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await Services.showModelScreen(context);
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
        leading: Image.asset('images/AI_image.png'),
        backgroundColor: Color(0xFFF5C228),
        title: const Text(
          'AI Ananlysis',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    msg: chatMessages[index]['msg'].toString(),
                    chatIndex:
                        int.parse(chatMessages[index]['chatIndex'].toString()),
                  );
                },
              ),
            ),
            if (isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.black,
                size: 18,
              ),
              Row(
                children: [
                  const Padding(padding: EdgeInsets.all(8)),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (value) => print(value),
                      decoration: const InputDecoration(
                        hintText: 'How can I help you?',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await ApiService.getModels();
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              )
            ]
          ],
        ),
      ),
    );
  }
}
