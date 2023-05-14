import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parcial_moviles/utils/api/errors.dart';

import '../connection.dart';

Future<void> sendMessage(
    String jwt, String recipientUUID, String title, String msg) async {
  http.Response response = await http.put(
    Uri.parse('$baseAPIUrl/api/message'),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt"
    },
    body: jsonEncode(
        {"recipientUUID": recipientUUID, "title": title, "body": msg}),
  );
  switch (response.statusCode) {
    case 200: // Succeed
      return;
    case 400: // Bad request
      throw BadRequestError();
    case 401: // Bad request
      throw UnauthorizedError();
    case 500: // Internal server error
      throw InternalServerError();
  }
}
