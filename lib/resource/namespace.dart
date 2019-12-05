part of dart_k8s_client;

@JsonSerializable()
class Namespace {
  static const ResourceKind kind = ResourceKind.Namespace;
  String name;
  DateTime creationTimestamp;
  String statusPhase;

  Namespace(this.name, this.creationTimestamp, this.statusPhase);

  factory Namespace.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> namespaceMeta = json["metadata"];
    return Namespace(
        namespaceMeta["name"],
        DateTime.parse(namespaceMeta["creationTimestamp"]),
        json["status"]["phase"]);
  }
}
