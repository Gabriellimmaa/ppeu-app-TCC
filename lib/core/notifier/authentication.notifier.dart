import 'package:flutter/material.dart';
import 'package:ppue/core/service/authentication.service.dart';
import 'package:ppue/routes/app.routes.dart';

class AuthenticationNotifier extends ChangeNotifier {
  final AuthenticationService _authenticationService =
      new AuthenticationService();

  Future<String?> singup({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await _authenticationService.singup(
          context: context, email: email, password: password);
      Navigator.popAndPushNamed(context, '/singin');
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<String?> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await _authenticationService.login(
          context: context, email: email, password: password);
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.SelectUserRoute,
        (route) => false,
      );
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<String?> logout({
    required BuildContext context,
  }) async {
    try {
      await _authenticationService.logout(context: context);
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.WelcomeRoute,
        (route) => false,
      );
    } catch (e) {
      print(e);
    }
    return null;
  }
}
