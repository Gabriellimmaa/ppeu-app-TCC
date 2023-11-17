// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:ppeu/core/service/authentication.service.dart';
import 'package:ppeu/models/HospitalUnit.model.dart';
import 'package:ppeu/routes/app.routes.dart';
import 'package:ppeu/screens/Home.screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationNotifier extends ChangeNotifier {
  final AuthenticationService _authenticationService = AuthenticationService();

  String? _type;
  HospitalUnitModel? _hospitalUnit;
  String _firstName = '';
  String _lastName = '';
  String _taxId = '';
  String? get type => _type;
  HospitalUnitModel? get hospitalUnit => _hospitalUnit;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get taxId => _taxId;
  bool get isMovel => _type == UserType.MOBILE_UNIT;
  bool get isHospital => _type == UserType.HOSPITAL_UNIT;

  void setUser({
    required String type,
    required HospitalUnitModel hospitalUnit,
    required BuildContext context,
  }) {
    _type = type;
    _hospitalUnit = hospitalUnit;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('type', type);
      prefs.setString('hospitalUnit', hospitalUnit.toJsonString());
    });

    notifyListeners();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  void setUserMetadata({
    required String firstName,
    required String lastName,
    required String taxId,
  }) {
    _firstName = firstName;
    _lastName = lastName;
    _taxId = taxId;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('firstName', firstName);
      prefs.setString('lastName', lastName);
      prefs.setString('taxId', taxId);
    });

    notifyListeners();
  }

  Future<String?> singup({
    required BuildContext context,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String taxId,
  }) async {
    var response = await _authenticationService.singup(
        context: context,
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        taxId: taxId);

    if (response.error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cadastro realizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.popAndPushNamed(context, '/singin');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error!.message),
          backgroundColor: Colors.red,
        ),
      );
    }

    return null;
  }

  Future<String?> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    var response = await _authenticationService.login(
        context: context, email: email, password: password);

    if (response.error == null) {
      setUserMetadata(
        firstName: response.data!.user!.userMetadata['firstName'],
        lastName: response.data!.user!.userMetadata['lastName'],
        taxId: response.data!.user!.userMetadata['taxId'],
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login realizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.SelectUserRoute,
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Usuário ou senha inválidos'),
          backgroundColor: Colors.red,
        ),
      );
    }

    return null;
  }

  Future logout({
    required BuildContext context,
  }) async {
    var response = await _authenticationService.logout(context: context);
    if (response.error == null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.WelcomeRoute,
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao realizar logout'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class UserType {
  static const String MOBILE_UNIT = 'MOBILE_UNIT';
  static const String HOSPITAL_UNIT = 'HOSPITAL_UNIT';

  static final routes = {
    MOBILE_UNIT: MOBILE_UNIT,
    HOSPITAL_UNIT: HOSPITAL_UNIT,
  };
}
