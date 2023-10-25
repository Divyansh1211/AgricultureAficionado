import 'dart:io';
import 'dart:typed_data';
import 'package:agriculture_aficionado/Components/mesaage_bubble.dart';
import 'package:agriculture_aficionado/Screens/welcome_screen.dart';
import 'package:agriculture_aficionado/constants.dart';
import 'package:agriculture_aficionado/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

User? loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'Chat_Screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String? messagetext;
  Uint8List? _image;

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, WelcomeScreen.id);
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser!;
      loggedInUser = user;
        } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      final storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().toString()}.jpg');
      final uploadTask = storageReference.putFile(imageFile);
      await uploadTask.whenComplete(() {});
      final imageUrl = await storageReference.getDownloadURL();
      if (kDebugMode) {
        print('secuessfully uploaded image: $imageUrl');
      }
      return imageUrl;
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading image: $e');
      }
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () {
                logout();
              }),
        ],
        title: const Text(
          'Community Tab',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFF5C228),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(firestore: _firestore),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      onChanged: (value) {
                        messagetext = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (messagetext != null && messagetext!.isNotEmpty) {
                        setState(() {
                          messageController.clear();
                          _firestore.collection('messages').add({
                            'text': messagetext,
                            'imageUrl': '',
                            'sender': loggedInUser?.email,
                            'time': FieldValue.serverTimestamp(),
                          });
                        });
                      }
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        final pickedFile = await ImagePicker()
                            .pickImage(source: ImageSource.camera);
                        if (pickedFile != null) {
                          final imageFile = File(pickedFile.path);
                          final imageUrl =
                              await uploadImageToFirebaseStorage(imageFile);
                          _firestore.collection('messages').add({
                            'text': '',
                            'imageUrl': imageUrl,
                            'sender': loggedInUser?.email,
                            'time': FieldValue.serverTimestamp(),
                          });
                        }
                      },
                      child: const Icon(Icons.camera_alt),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({
    super.key,
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        try {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final messages = snapshot.data?.docs.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages!) {
            final messageText = message.get('text');
            final imageUrl = message.get('imageUrl');
            final messageSender = message.get('sender');
            final currentUser = loggedInUser?.email;

            final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
              imageUrl: imageUrl,
              isME: currentUser == messageSender,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              children: messageBubbles,
            ),
          );
        } catch (e) {
          print(e);
        }
        throw (e) {};
      },
    );
  }
}
