import 'package:flutter/material.dart';
import 'package:parcial_moviles/utils/firebase/fcm.dart';
import 'package:parcial_moviles/views/home.dart';
import 'package:parcial_moviles/views/login.dart';
import 'package:parcial_moviles/views/register.dart';
import 'package:parcial_moviles/views/users.dart';

void main() async {
  await setupFirebaseListener();
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parcial moviles',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/login": (ctx) => const LoginView(),
        "/register": (ctx) => const RegisterView(),
        "/users": (ctx) => UsersView()
      },
      home: const HomeView(),
    );
  }
}
