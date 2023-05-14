import 'package:flutter/material.dart';
import 'package:parcial_moviles/utils/api/message.dart';

import '../utils/api/types.dart';

class MessageView extends StatefulWidget {
  String b64Jwt;
  User user;
  MessageView(this.b64Jwt, this.user, {super.key});

  @override
  State<StatefulWidget> createState() => _MessageView();
}

class _MessageView extends State<MessageView> {
  TextEditingController titController = TextEditingController();
  TextEditingController msgController = TextEditingController();

  Future<void> doSendMessage() async {
    sendMessage(widget.b64Jwt, widget.user.uuid, titController.text,
        msgController.text);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parcial moviles',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text("Message")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(label: Text("Title")),
                controller: titController,
              ),
              TextField(
                decoration: const InputDecoration(
                  label: Text("Message"),
                ),
                controller: msgController,
              ),
              ElevatedButton(
                  onPressed: doSendMessage, child: const Text("Send")),
            ],
          ),
        ),
      ),
    );
  }
}
