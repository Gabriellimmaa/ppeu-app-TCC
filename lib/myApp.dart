import 'package:flutter/material.dart';
import 'package:ppue/screens/SelectUser.screen.dart';

import 'screens/Welcome.screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/select_user': (context) => SelectUserScreen(),
      },
    );
  }
}
