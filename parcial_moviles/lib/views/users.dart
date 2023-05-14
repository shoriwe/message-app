import 'package:flutter/material.dart';
import 'package:parcial_moviles/components/user.dart';
import 'package:parcial_moviles/utils/api/login.dart';
import 'package:parcial_moviles/utils/api/types.dart';
import 'package:parcial_moviles/utils/api/users.dart';
import 'package:parcial_moviles/utils/session.dart';
import 'package:parcial_moviles/views/home.dart';

class UsersView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UsersView();
}

class _UsersView extends State<UsersView> {
  int currentPage = 0;
  List<UserWidget> listedUsers = [];

  Future<void> doLogout() async {
    String? jwt = await getSession();
    if (jwt == null) {
      Navigator.pushReplacementNamed(context, "/login");
      return;
    }
    try {
      await logout(jwt);
    } catch (e) {
      print(e);
    }
    await delSession();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (ctx) => HomeView()),
    );
  }

  Future<void> loadUsers() async {
    try {
      String? jwt = await getSession();
      List<User> queryUsers = await users(jwt!, currentPage);
      listedUsers = [];
      for (int index = 0; index < queryUsers.length; index++) {
        listedUsers.add(UserWidget(jwt, queryUsers[index]));
      }
      setState(() {});
    } catch (e) {
      print(e);
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
        appBar: AppBar(
          title: const Text("Users"),
          actions: [
            ElevatedButton(onPressed: doLogout, child: const Text("Logout"))
          ],
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (currentPage <= 1) return;
                      currentPage--;
                      loadUsers();
                    },
                    child: const Text("Prev")),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text("$currentPage"),
                ),
                ElevatedButton(
                    onPressed: () {
                      // if (currentPage > 1 && listedUsers.length < 100) return;
                      currentPage++;
                      loadUsers();
                    },
                    child: const Text("Next"))
              ],
            ),
            Expanded(child: ListView(children: listedUsers)),
          ],
        ),
      ),
    );
  }
}
