class WrongPasswordException implements Exception {
  final String _message;
  WrongPasswordException() : _message = 'A senha informada está errada';

  @override
  String toString() => _message;
}
