import 'package:flutter/material.dart';
import 'package:parcial_moviles/utils/api/types.dart';
import 'package:parcial_moviles/views/message.dart';

import '../utils/connection.dart';

class UserView extends StatefulWidget {
  String b64Jwt;
  User user;
  UserView(this.b64Jwt, this.user, {super.key});

  @override
  State<StatefulWidget> createState() => _UserView();
}

class _UserView extends State<UserView> {
  Future<void> goMessage() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => MessageView(widget.b64Jwt, widget.user)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parcial moviles',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.user.name),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2),
                    ),
                    width: 100,
                    height: 100,
                    child: Image.network(
                      "$baseAPIUrl/api/picture/${widget.user.uuid}",
                      headers: {"Authorization": "Bearer ${widget.b64Jwt}"},
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    "Name: ${widget.user.name}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Email: ${widget.user.email}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Job: ${widget.user.job}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Phone number: ${widget.user.phoneNumber}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  ElevatedButton(
                      onPressed: goMessage, child: const Text("Message")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
