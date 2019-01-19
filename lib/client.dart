library dart_k8s_client;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

part 'resource/resource.dart';
part 'resource/namespace.dart';
part 'resource/namespace_list.dart';

class DartKubernetesClient {
  String url;
  http.Client clientHttp;

  DartKubernetesClient(this.url) {
    _parseUrl(url);
    clientHttp = new http.Client();
  }

  Future<String> getVersion() async {
    Response response = await clientHttp.get(url + "/version");
    clientHttp.close();
    return response.body;
  }

  Future<NamespaceList> getNamespaceList() async {
    Response response = await clientHttp.get(url + "/api/v1/namespaces");
    return new NamespaceList(jsonDecode(response.body));
  }

  void _parseUrl(String url) {
    Uri uri = Uri.parse(url);
    String scheme = uri.hasScheme ? uri.scheme : "http";
    String port = uri.hasPort ? uri.port.toString() : "8443";
    this.url = scheme + "://" + uri.host + ":" + port;
  }
}
