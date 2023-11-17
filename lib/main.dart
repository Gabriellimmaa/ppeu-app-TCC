import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:ppeu/providers/app.provider.dart';
import 'package:provider/provider.dart';

import 'MyApp.dart';

void main() {
  initializeDateFormatting('pt_BR', null).then((_) {
    runApp(MultiProvider(providers: AppProviders().providers, child: MyApp()));
  });
}
