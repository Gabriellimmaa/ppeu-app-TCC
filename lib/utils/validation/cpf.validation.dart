// Exportação da função de validação de CPF
export 'cpf.validation.dart';

bool validateCPF(String cpf) {
  if (cpf.isEmpty) {
    return false;
  }

  // Remove caracteres especiais do CPF
  cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');

  // Verifica se o CPF tem 11 dígitos
  if (cpf.length != 11) {
    return false;
  }

  // Verifica se todos os dígitos são iguais (caso contrário, não é válido)
  if (RegExp(r'^(\d)\1+$').hasMatch(cpf)) {
    return false;
  }

  // Calcula o primeiro dígito verificador
  int digit1 = 0;
  for (int i = 0; i < 9; i++) {
    digit1 += int.parse(cpf[i]) * (10 - i);
  }
  digit1 = 11 - digit1 % 11;
  if (digit1 > 9) {
    digit1 = 0;
  }

  // Calcula o segundo dígito verificador
  int digit2 = 0;
  for (int i = 0; i < 10; i++) {
    digit2 += int.parse(cpf[i]) * (11 - i);
  }
  digit2 = 11 - digit2 % 11;
  if (digit2 > 9) {
    digit2 = 0;
  }

  // Verifica se os dígitos verificadores estão corretos
  if (int.parse(cpf[9]) != digit1 || int.parse(cpf[10]) != digit2) {
    return false;
  }

  return true;
}
