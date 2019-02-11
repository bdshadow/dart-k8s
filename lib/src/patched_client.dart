import 'dart:convert';
import 'dart:io';

import 'package:dart_kubernetes_client/client.dart';
import 'package:dart_kubernetes_client/src/utils.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

class PatchedIOClient extends IOClient {
  String _token;
  String _username;
  String _password;

  PatchedIOClient._(HttpClient httpClient) : super(httpClient);

  // https://stackoverflow.com/questions/50684784/how-to-super-call-with-complex-arguments-in-dart
  factory PatchedIOClient({String token, String username, String password, bool ignoreCertificateCheck = false}) {
    if (token != null && username != null) {
      throw Exception("You must provide only one of token or username, not both");
    }
    HttpClient httpClient = new HttpClient();
    if (ignoreCertificateCheck) {
      httpClient.badCertificateCallback =
          (X509Certificate certificate, host, port) {
        return true;
      };
    }
    PatchedIOClient patchedClient = new PatchedIOClient._(httpClient);
    if (token != null) {
      patchedClient._token = token;
    } else if (username != null) {
      patchedClient._username = username;
      patchedClient._password = password;
    }
    return patchedClient;
  }

  Future<Response> get(url, {Map<String, String> headers}) async {
    Response response;
    if (token != null) {
      response = await super
          .get(url, headers: {"Authorization": getOAuthCredential(token)});
    } else if (username != null) {
      response = await super
          .get(url, headers: {"Authorization": getBasicAuthCredential(username, password)});
    } else {
      response = await super.get(url);
    }
    if (response.statusCode == 403) {
      throw AccessDeniedException(_parseMessage(response.body));
    }
    return Future.value(response);
  }

  String _parseMessage(String json) {
    return jsonDecode(json)["message"];
  }

  String get username => _username;
  String get password => _password;
  String get token => _token;
}
