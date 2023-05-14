import 'dart:convert';

import 'package:parcial_moviles/utils/api/errors.dart';
import 'package:parcial_moviles/utils/api/types.dart';

import 'package:http/http.dart' as http;
import 'package:parcial_moviles/utils/connection.dart';

Future<List<User>> users(String jwt, int page) async {
  http.Response response = await http.post(
    Uri.parse("$baseAPIUrl/api/users"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt"
    },
    body: jsonEncode({"page": page, "pageSize": 100}),
  );
  switch (response.statusCode) {
    case 200: // Succeed
      break;
    case 400: // Bad request:
      throw BadRequestError();
    case 401: // Unauthorized
      throw UnauthorizedError();
    case 500:
      throw InternalServerError();
    default:
      throw Exception("Unknown status code");
  }
  List<User> result = [];
  List<dynamic> rawUsers = jsonDecode(response.body);
  for (int index = 0; index < rawUsers.length; index++) {
    Map<String, dynamic> rawUser = rawUsers[index];
    User user = User();
    user.uuid = rawUser["uuid"];
    user.email = rawUser["email"];
    user.name = rawUser["name"];
    user.phoneNumber = rawUser["phoneNumber"];
    user.job = rawUser["job"];
    result.add(user);
  }
  return result;
}
