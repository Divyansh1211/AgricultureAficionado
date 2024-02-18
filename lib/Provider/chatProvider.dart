import 'package:agriculture_aficionado/Components/api_service.dart';
import 'package:agriculture_aficionado/Model/chatModel.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatMessages = [];
  List<ChatModel> get getChatMessages => chatMessages;

  void addUserMessage(String message) {
    chatMessages.add(ChatModel(msg: message, chatIndex: 0));
    notifyListeners();
  }

  Future<void> addAIResponse(String message) async {
    chatMessages.addAll(await ApiService.sendMessages(message));
    notifyListeners();
  }
}
