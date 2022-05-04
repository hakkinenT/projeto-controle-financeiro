class UserNotFoundException implements Exception {
  final String _message;

  UserNotFoundException()
      : _message = 'Não há um usuário cadastrado para esse email';

  @override
  String toString() => _message;
}
