class HttpExpcetion implements Exception {
  final String message;
  HttpExpcetion(this.message);

  String toString() {
    return super.toString();
  }
}
