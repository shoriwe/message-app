import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parcial_moviles/utils/api/errors.dart';

import 'package:parcial_moviles/utils/api/types.dart';

import '../connection.dart';

Future<void> register(User user) async {
  http.Response response = await http.put(
    Uri.parse('$baseAPIUrl/api/register'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(user.registerForm()),
  );
  switch (response.statusCode) {
    case 201: // Succeed
      return;
    case 400: // Bad request
      throw BadRequestError();
    case 500: // Internal server error
      throw InternalServerError();
  }
}
