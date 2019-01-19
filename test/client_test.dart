import 'package:dart_kubernetes_client/client.dart';
import "package:test/test.dart";


void main() {
  test("Default client test", () async {
    DartKubernetesClient client = new DartKubernetesClient("http://127.0.0.1:8001");
    var result = await client.getVersion();
    print(result);
  });

  test("NamespacesList test", () async {
    DartKubernetesClient client = new DartKubernetesClient("http://127.0.0.1:8001");
    var result = await client.getNamespaceList();
    print(result.items.first.name);
  });
}
