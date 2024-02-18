import 'package:agriculture_aficionado/Components/api_service.dart';
import 'package:agriculture_aficionado/Components/services.dart';
import 'package:agriculture_aficionado/Model/chatModel.dart';
import 'package:agriculture_aficionado/Widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Analysis extends StatefulWidget {
  static const String id = 'Analysis';

  const Analysis({super.key});
  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  bool isTyping = true;

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController;
    _controller;
    _focusNode;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  List<ChatModel> chatMessages = [];

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
        backgroundColor: const Color(0xFFF5C228),
        title: const Text(
          'AI Ananlysis',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: chatMessages.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    msg: chatMessages[index].msg,
                    chatIndex: chatMessages[index].chatIndex,
                  );
                },
              ),
            ),
            if (isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.black,
                size: 18,
              ),
            ],
            Row(
              children: [
                const Padding(padding: EdgeInsets.all(8)),
                Expanded(
                  child: TextField(
                    focusNode: _focusNode,
                    controller: _controller,
                    onSubmitted: (value) async {
                      await sendMessagesFCT();
                    },
                    decoration: const InputDecoration(
                      hintText: 'How can I help you?',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await sendMessagesFCT();
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void scroller() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> sendMessagesFCT() async {
    try {
      setState(
        () {
          isTyping = true;
          chatMessages.add(ChatModel(msg: _controller.text, chatIndex: 0));
          _controller.clear();
          _focusNode.unfocus();
        },
      );
      chatMessages.addAll(
        await ApiService.sendMessages(
          _controller.text,
        ),
      );
      setState(() {});
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        scroller();
        isTyping = false;
      });
    }
  }
}
