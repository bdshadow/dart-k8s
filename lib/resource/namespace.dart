part of dart_k8s_client;

class Namespace {
  static const ResourceKind kind = ResourceKind.Namespace;
  String name;
  DateTime creationTimestamp;
  Status statusPhase;

  Namespace(Map namespaceJsonMap) {
    this.name = namespaceJsonMap["metadata"]["name"];
    this.creationTimestamp =
        DateTime.parse(namespaceJsonMap["metadata"]["creationTimestamp"]);
    this.statusPhase = Status.values.firstWhere(
        (s) => s.toString() == "Status." + namespaceJsonMap["status"]["phase"]);
  }
}
