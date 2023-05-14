import 'package:flutter/material.dart';
import 'package:parcial_moviles/utils/connection.dart';
import 'package:parcial_moviles/views/user.dart';

import '../utils/api/types.dart';

class UserWidget extends StatelessWidget {
  String b64Jwt;
  User user;
  UserWidget(this.b64Jwt, this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.transparent),
        ),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => UserView(b64Jwt, user))),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                  ),
                  width: 100,
                  height: 100,
                  child: Image.network(
                    "$baseAPIUrl/api/picture/${user.uuid}",
                    headers: {"Authorization": "Bearer $b64Jwt"},
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(fontSize: 30),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        user.email,
                        style: const TextStyle(fontSize: 30),
                      )
                    ],
                  ),
                ],
              ))
            ],
          ),
        ));
  }
}
