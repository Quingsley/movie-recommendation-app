class Failure implements Exception {
  String message;
  int? code;
  Exception? exception;
  Failure({required this.message, this.exception, this.code});
}
