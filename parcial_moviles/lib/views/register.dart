import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parcial_moviles/utils/api/register.dart';

import 'dart:async';

import '../utils/api/types.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterView();
}

class _RegisterView extends State<RegisterView> {
  final ImagePicker picker = ImagePicker();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  String imageB64 = "";

  Future<void> doRegister() async {
    if (imageB64.length == 0) return;
    User user = User();
    user.email = emailController.text;
    user.password = passwordController.text;
    user.name = nameController.text;
    user.phoneNumber = phoneController.text;
    user.job = jobController.text;
    user.profilePicture = imageB64;
    register(user)
        .then((value) => Navigator.pushReplacementNamed(context, "/login"))
        .catchError((error) => print(error));
  }

  Future<void> pickCamera() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    imageB64 = base64Encode(await image.readAsBytes());
  }

  Future<void> pickGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    imageB64 = base64Encode(await image.readAsBytes());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parcial moviles',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text("Register")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(label: Text("Email")),
                controller: emailController,
              ),
              TextField(
                decoration: const InputDecoration(label: Text("Name")),
                controller: nameController,
              ),
              TextField(
                decoration: const InputDecoration(label: Text("Phone Number")),
                controller: phoneController,
              ),
              TextField(
                decoration: const InputDecoration(label: Text("Job")),
                controller: jobController,
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text("Password"),
                ),
                controller: passwordController,
              ),
              ElevatedButton(
                  onPressed: pickCamera,
                  child: const Text("Pick image from camera")),
              ElevatedButton(
                  onPressed: pickGallery,
                  child: const Text("Pick image from gallery")),
              ElevatedButton(
                  onPressed: doRegister, child: const Text("Register")),
            ],
          ),
        ),
      ),
    );
  }
}
