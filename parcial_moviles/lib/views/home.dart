import 'package:flutter/material.dart';
import 'package:parcial_moviles/utils/firebase/fcm.dart';
import 'package:parcial_moviles/utils/session.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    getSession().then((value) {
      if (value == null) return;
      Navigator.pushReplacementNamed(context, "/users");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, "/login"),
              child: const Text("Login")),
          ElevatedButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, "/register"),
              child: const Text("Register"))
        ],
      )),
    );
  }
}
