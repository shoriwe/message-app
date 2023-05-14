import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

FlutterSecureStorage? storage;

FlutterSecureStorage getStorage() {
  storage ??= const FlutterSecureStorage();
  return storage!;
}

const String sessionKey = "sessionJWT";

Future<String?> getSession() async {
  return await getStorage().read(key: sessionKey);
}

Future<void> setSession(String jwt) async {
  await getStorage().write(key: sessionKey, value: base64Encode(jwt.codeUnits));
}

Future<void> delSession() async {
  await getStorage().delete(key: sessionKey);
}
