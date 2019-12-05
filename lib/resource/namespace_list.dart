part of dart_k8s_client;

class NamespaceList {
  static const ResourceKind kind = ResourceKind.NamespaceList;
  Set<Namespace> items;

  NamespaceList(this.items);

  factory NamespaceList.fromJson(Map<String, dynamic> json) {
    if (json["items"] == null) {
      return NamespaceList(HashSet<Namespace>());
    }
    return NamespaceList(Set<Namespace>.from(json["items"].map((i) => Namespace.fromJson(i))));
  }
}
