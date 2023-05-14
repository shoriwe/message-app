import 'package:flutter/material.dart';
import 'package:parcial_moviles/utils/api/login.dart';
import 'package:parcial_moviles/utils/api/types.dart';
import 'package:parcial_moviles/utils/session.dart';
import 'package:parcial_moviles/views/users.dart';

import '../utils/firebase/fcm.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<StatefulWidget> createState() => _LoginView();
}

class _LoginView extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> doLogin() async {
    Login form = Login();
    form.email = emailController.text;
    form.password = passwordController.text;
    form.firebaseToken = fcm;
    try {
      String jwt = await login(form);
      setSession(jwt);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (ctx) => UsersView()),
      );
    } catch (e) {
      print(e);
      //showDialog(
      //   context: context,
      //   builder: (BuildContext context) => AlertDialog(
      //         title: const Text("Error"),
      //         content: Text(e.toString()),
      //       ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parcial moviles',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(label: Text("Email")),
                controller: emailController,
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text("Password"),
                ),
                controller: passwordController,
              ),
              ElevatedButton(onPressed: doLogin, child: const Text("Login")),
            ],
          ),
        ),
      ),
    );
  }
}
