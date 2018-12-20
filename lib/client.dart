import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

bool callFunction(X509Certificate cert, String host, int port) {
  print(cert);
  return true;
}

void main() {
  var url = "https://192.168.39.219:8443/version";
  SecurityContext context = SecurityContext();
 // context.setTrustedCertificates("/home/dbocharo/.minikube/ca.crt");
  context.useCertificateChain("/home/dbocharo/.minikube/ca.crt");
  context.usePrivateKey("/home/dbocharo/.minikube/ca.key");
  //context.setClientAuthorities("/home/dbocharo/.minikube/ca.crt");
  HttpClient client = new HttpClient(context: context);
//  client.badCertificateCallback =
//      (X509Certificate cert, String host, int port) => callFunction(cert, host, port);
//  client.get("192.168.39.219", 8443, "version")
//      .then((HttpClientRequest request) => request.close())
//      .then((HttpClientResponse response) {
//    response.transform(utf8.decoder).listen((contents) {
//      print(contents);
//    });
//  });
  client.getUrl(Uri.parse(url))
      .then((HttpClientRequest request) => request.close())
      .then((HttpClientResponse response) {
    response.transform(utf8.decoder).listen((contents) {
      print(contents);
    });
  });

//  var httpClient = new IOClient(client);
//  httpClient.get(url).then((response) => print(response.body))
//      .whenComplete(client.close);

}
