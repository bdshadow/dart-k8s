part of dart_k8s_client;

class NamespaceList {
  static const ResourceKind kind = ResourceKind.NamespaceList;
  Set<Namespace> items = HashSet<Namespace>();

  NamespaceList(this.items);

  factory NamespaceList.fromJson(Map<String, dynamic> json) {
    return NamespaceList(Set<Namespace>.from(json["items"].map((i) => Namespace.fromJson(i))));
  }
}
