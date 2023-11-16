// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:ppue/core/service/authentication.service.dart';
import 'package:ppue/routes/app.routes.dart';
import 'package:ppue/screens/Home.screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationNotifier extends ChangeNotifier {
  final AuthenticationService _authenticationService = AuthenticationService();

  String? _type;
  String _hospitalUnit = '';
  String _name = '';
  String _taxId = '';
  String? get type => _type;
  String get hospitalUnit => _hospitalUnit;
  String get name => _name;
  String get taxId => _taxId;
  bool get isMovel => _type == UserType.MOBILE_UNIT;
  bool get isHospital => _type == UserType.HOSPITAL_UNIT;

  void setUser({
    required String type,
    required String hospitalUnit,
    required BuildContext context,
  }) {
    if (hospitalUnit == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Selecione um estabelecimento de saúde')));
      return;
    }

    _type = type;
    _hospitalUnit = hospitalUnit;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('type', type);
      prefs.setString('hospitalUnit', hospitalUnit);
    });

    notifyListeners();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  void setUserMetadata({
    required String name,
    required String taxId,
  }) {
    _name = name;
    _taxId = taxId;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('name', name);
      prefs.setString('taxId', taxId);
    });

    notifyListeners();
  }

  Future<String?> singup({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String taxId,
  }) async {
    var response = await _authenticationService.singup(
        context: context,
        email: email,
        password: password,
        name: name,
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
        name: response.data!.user!.userMetadata['name'],
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
