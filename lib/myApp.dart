import 'package:flutter/material.dart';
import 'package:ppeu/routes/app.routes.dart';

import 'screens/Welcome.screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 100, 177, 240),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 39, 132, 208),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusColor: Color.fromARGB(255, 39, 132, 208),
        ),
        colorScheme: ColorScheme.light(
          primary: Color.fromARGB(255, 71, 157, 227),
          outline: Colors.grey[500],
          onSurface: Colors.black87,
        ),
      ),
      home: WelcomeScreen(),
      routes: AppRoutes.routes,
    );
  }
}
