import 'package:intl/intl.dart';

enum FormatDate {
  diaMesAno,
  diaMesNomeAno,
  horaMinutoSegundo,
  diaMesAnoHoraMinutoSegundo,
  diaMesAnoHoraMinuto
}

String formatDate(DateTime date, {FormatDate format = FormatDate.diaMesAno}) {
  String pattern;
  switch (format) {
    case FormatDate.diaMesAno:
      pattern = 'dd/MM/yyyy';
      break;
    case FormatDate.diaMesNomeAno:
      pattern = 'dd MMMM yyyy';
      break;
    case FormatDate.horaMinutoSegundo:
      pattern = 'HH:mm:ss';
      break;
    case FormatDate.diaMesAnoHoraMinutoSegundo:
      pattern = 'dd/MM/yyyy HH:mm:ss';
      break;
    case FormatDate.diaMesAnoHoraMinuto:
      pattern = 'dd/MM/yyyy HH:mm';
      break;
  }

  final formatador = DateFormat(pattern);
  return formatador.format(date);
}
