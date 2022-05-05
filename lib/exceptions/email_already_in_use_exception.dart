class EmailAlreadyInUseException implements Exception {
  final String _message;

  EmailAlreadyInUseException()
      : _message = "Já existe uma conta para esse email";

  @override
  String toString() => _message;
}
