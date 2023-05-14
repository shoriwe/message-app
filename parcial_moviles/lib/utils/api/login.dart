import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parcial_moviles/utils/connection.dart';
import 'package:parcial_moviles/utils/api/errors.dart';
import 'package:parcial_moviles/utils/api/types.dart';

Future<String> login(Login form) async {
  http.Response response = await http.post(Uri.parse("$baseAPIUrl/api/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(form.loginForm()));
  switch (response.statusCode) {
    case 200: // Succeed
      return (Response(response.body)).result;
    case 400: // Bad request
      throw BadRequestError();
    case 401: // Unauthorized
      throw UnauthorizedError();
    case 500: // Internal server error
      throw InternalServerError();
    default:
      throw Exception("Unknown status code");
  }
}

Future<void> logout(String jwt) async {
  http.Response response = await http.post(Uri.parse("$baseAPIUrl/api/logout"),
      headers: {"Authorization": "Bearer $jwt"});
  switch (response.statusCode) {
    case 200: // Succeed
      return;
    case 400: // Bad request
      throw BadRequestError();
    case 401: // Unauthorized
      throw UnauthorizedError();
    case 500: // Internal server error
      throw InternalServerError();
    default:
      throw Exception("Unknown status code");
  }
}
