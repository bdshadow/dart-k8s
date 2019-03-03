part of dart_k8s_client;

class NamespaceList {
  static const ResourceKind kind = ResourceKind.NamespaceList;
  Set<Namespace> items = HashSet<Namespace>();

  NamespaceList(Map namespaceJsonMap) {
    for (var nsItem in namespaceJsonMap["items"]) {
      this.items.add(new Namespace(nsItem));
    }
  }
}
