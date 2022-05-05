class WeakPasswordException implements Exception {
  final String _message;

  WeakPasswordException() : _message = "A senha informada é muito fraca";

  @override
  String toString() => _message;
}
