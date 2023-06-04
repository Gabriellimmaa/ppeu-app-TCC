export 'email.validation.dart';

bool validateEmail(String email) {
  // Expressão regular para validar o formato de email
  final RegExp emailRegex =
      RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  // Verifica se o email corresponde ao formato esperado
  return emailRegex.hasMatch(email);
}
