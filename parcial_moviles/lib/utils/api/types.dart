import 'dart:convert';

class User {
  late String uuid;
  late String email;
  late String password;
  late String phoneNumber;
  late String profilePicture;
  late String name;
  late String job;
  Map<String, String> registerForm() {
    return {
      "email": email,
      "password": password,
      "phoneNumber": phoneNumber,
      "profilePicture": profilePicture,
      "name": name,
      "job": job
    };
  }
}

class Login {
  late String email;
  late String password;
  late String firebaseToken;

  Map<String, String> loginForm() {
    return {
      "email": email,
      "password": password,
      "firebaseToken": firebaseToken
    };
  }
}

class Response {
  late String result;

  Response(String s) {
    Map<String, dynamic> response = jsonDecode(s);
    if (response.containsKey("result")) {
      result = response["result"]!;
    }
  }
}
