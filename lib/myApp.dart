import 'package:flutter/material.dart';
import 'package:ppue/screens/SelectUser.screen.dart';
import 'package:ppue/screens/Signin.screen.dart';
import 'package:ppue/screens/Signup.screen.dart';

import 'screens/Welcome.screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF00cccb),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      home: WelcomeScreen(),
      routes: {
        '/select_user': (context) => SelectUserScreen(),
        '/singin': (context) => SigninScreen(),
        '/signup': (context) => SignupScreen(),
        '/welcome': (context) => WelcomeScreen(),
      },
    );
  }
}
