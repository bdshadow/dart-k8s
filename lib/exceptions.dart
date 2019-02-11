part of dart_k8s_client;

class AccessDeniedException extends IOException {
  final String message;

  AccessDeniedException(this.message);

  String toString() {
    var b = new StringBuffer()..write('AccessDeniedException: ')..write(message);
    return b.toString();
  }
}