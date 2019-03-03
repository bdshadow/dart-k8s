import 'package:dart_kubernetes_client/client.dart';
import "package:test/test.dart";


void main() {

  // kubectl describe secret default -n kube-system
  String token = "";
  //String url = "https://192.168.39.178:8443";
  String url = "http://127.0.0.1:8001";
  final DartKubernetesClient client = new DartKubernetesClient.oAuthClient(url, token);

  test("Default client test", () async {
    var result = await client.getVersion();
    print(result);
  });

  test("NamespacesList test", () async {
    var result = await client.getNamespaceList();
    print(result.items.first.name);
  });
}
