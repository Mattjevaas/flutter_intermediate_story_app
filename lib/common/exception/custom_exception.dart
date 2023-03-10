class CustomException implements Exception {
  final String _message;

  CustomException({required String message}) : _message = message;

  String get message => _message;
}
