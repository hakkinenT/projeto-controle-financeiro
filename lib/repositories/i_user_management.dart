import 'package:projeto_controle_financeiro/models/user_model.dart';

abstract class IUserManagement {
  Future<UserModel?> registrationWithEmailAndPassword(
      String name, String email, String password);

  void updateEmail({required String newEmail});
  void updatePassword({required String newPassword});
  void deleteUser();
}
