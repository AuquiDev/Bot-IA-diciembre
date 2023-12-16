import '../helpers/exports.dart';

class RegisterControllers {
  register(TextEditingController emailControllers,
      TextEditingController passowrdControllers) async {
    String email = emailControllers.text;
    String password = passowrdControllers.text;

    if (email.isNotEmpty || password.isNotEmpty) {
      List response =
          await AuthConnections().registerUser(mail: email, password: password);
      return response;
    } else {
      return [false, "Por Favor, llena los campos."];
    }
  }
}
