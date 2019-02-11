library dart_k8s_client;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dart_kubernetes_client/src/patched_client.dart';
import 'package:http/http.dart';

part 'resource/resource.dart';
part 'resource/namespace.dart';
part 'resource/namespace_list.dart';
part 'package:dart_kubernetes_client/exceptions.dart';

class DartKubernetesClient {
  String url;
  Client clientHttp;

  DartKubernetesClient(this.url, {String token, bool ignoreCertificateCheck = false}) {
    _parseUrl(url);
    this.clientHttp = new PatchedIOClient(token:token, ignoreCertificateCheck:ignoreCertificateCheck);
  }

  Future<String> getVersion() async {
    Response response = await clientHttp.get(url + "/version");
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

  void close() {
    clientHttp.close();
  }
}
