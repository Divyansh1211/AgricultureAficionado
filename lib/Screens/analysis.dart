import 'package:agriculture_aficionado/Provider/chatProvider.dart';
import 'package:agriculture_aficionado/Widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Analysis extends StatefulWidget {
  static const String id = 'Analysis';

  const Analysis({super.key});
  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  bool isTyping = false;

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

  // List<ChatModel> chatMessages = [];

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {},
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
                itemCount: chatProvider.getChatMessages.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    msg: chatProvider.getChatMessages[index].msg,
                    chatIndex: chatProvider.getChatMessages[index].chatIndex,
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
                      await sendMessagesFCT(chatProvider);
                    },
                    decoration: const InputDecoration(
                      hintText: 'How can I help you?',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await sendMessagesFCT(chatProvider);
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

  Future<void> sendMessagesFCT(ChatProvider chatProvider) async {
    if (isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kripya Prateeksha Karein...'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (_controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a message'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      String msg = _controller.text;
      setState(
        () {
          isTyping = true;
          chatProvider.addUserMessage(msg);
          _controller.clear();
          _focusNode.unfocus();
        },
      );
      await chatProvider.addAIResponse(msg);

      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        scroller();
        isTyping = false;
      });
    }
  }
}
