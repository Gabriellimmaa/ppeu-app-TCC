import 'package:ppeu/utils/validation/cpf.validation.dart';
import 'package:ppeu/utils/validation/email.validation.dart';

class FormValidators {
  static String? Function(String?) compose(
      List<String? Function(String?)> validators) {
    return (value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) {
          return error;
        }
      }
      return null;
    };
  }

  static String? required(dynamic value, {bool condition = true}) {
    if (condition &&
        (value == null ||
            (value is String && value.isEmpty) ||
            (value == null))) {
      return 'Campo obrigatório';
    }

    return null;
  }

  static String? email(String? value) {
    if (value != null && value.isNotEmpty) {
      if (!validateEmail(value)) {
        return 'E-mail inválido';
      }
    }
    return null;
  }

  static String? cpf(String? value) {
    if (value != null && value.isNotEmpty) {
      if (!validateCPF(value)) {
        return 'CPF inválido';
      }
    }
    return null;
  }
}
