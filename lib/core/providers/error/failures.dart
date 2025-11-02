class Failure {
  final Exception? error;
  Failure({this.error});
}

class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}
