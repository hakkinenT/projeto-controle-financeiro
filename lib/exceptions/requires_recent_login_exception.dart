class RequiresRecentLoginException implements Exception {
  final String _message;

  RequiresRecentLoginException()
      : _message =
            "É necessário se autenticar novamente para executar essa operação";

  @override
  String toString() {
    return _message;
  }
}
