import 'dart:convert';

String getBasicAuthCredential(String username, String password) {
  return "Basic " + base64.encode(utf8.encode(username + ":" + password));
}

String getOAuthCredential(String token) {
  return "Bearer " + token;
}