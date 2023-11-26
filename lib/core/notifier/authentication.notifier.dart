// ignore_for_file: use_build_context_synchronously
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ppeu/core/service/authentication.service.dart';
import 'package:ppeu/models/HospitalUnit.model.dart';
import 'package:ppeu/models/MobileUnit.model.dart';
import 'package:ppeu/routes/app.routes.dart';
import 'package:ppeu/screens/Home.screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationNotifier extends ChangeNotifier {
  final AuthenticationService _authenticationService = AuthenticationService();

  String? _type;
  HospitalUnitModel? _hospitalUnit;
  MobileUnitModel? _mobileUnit;
  String _firstName = '';
  String _lastName = '';
  String _taxId = '';
  String? get type => _type;

  List<MobileUnitModel>? _mobileUnits;
  MobileUnitModel? get mobileUnit => _mobileUnit;
  List<MobileUnitModel>? get mobileUnits => _mobileUnits;

  List<HospitalUnitModel>? _hospitalUnits;
  HospitalUnitModel? get hospitalUnit => _hospitalUnit;
  List<HospitalUnitModel>? get hospitalUnits => _hospitalUnits;

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get taxId => _taxId;
  bool get isMovel => _type == UserType.MOBILE_UNIT;
  bool get isHospital => _type == UserType.HOSPITAL_UNIT;

  void setUser({
    required String type,
    HospitalUnitModel? hospitalUnit,
    MobileUnitModel? mobileUnit,
    required BuildContext context,
  }) {
    _type = type;
    _hospitalUnit = hospitalUnit;
    _mobileUnit = mobileUnit;

    notifyListeners();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  void setUserMetadata({
    required String firstName,
    required String lastName,
    required String taxId,
    List<HospitalUnitModel>? hospitalUnits,
    List<MobileUnitModel>? mobileUnits,
  }) {
    _firstName = firstName;
    _lastName = lastName;
    _taxId = taxId;
    _hospitalUnits = hospitalUnits;
    _mobileUnits = mobileUnits;

    notifyListeners();
  }

  Future singup({
    required BuildContext context,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String taxId,
    List<HospitalUnitModel>? hospitalUnits,
    List<MobileUnitModel>? mobileUnits,
  }) async {
    if (hospitalUnits == null && mobileUnits == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selecione pelo menos uma unidade'),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }

    var response = await _authenticationService.singup(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        taxId: taxId,
        hospitalUnits: hospitalUnits,
        mobileUnits: mobileUnits);

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
  }

  Future<String?> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    var response =
        await _authenticationService.login(email: email, password: password);

    if (response.error == null) {
      List<dynamic>? hospitalUnits =
          response.data!.user!.userMetadata['hospitalUnits'];
      List<dynamic>? mobileUnits =
          response.data!.user!.userMetadata['mobileUnits'];

      List<HospitalUnitModel> hospitalUnitsList = [];
      List<MobileUnitModel> mobileUnitsList = [];
      for (var hospitalUnit in hospitalUnits!) {
        hospitalUnitsList.add(HospitalUnitModel.fromJson(hospitalUnit));
      }
      for (var mobileUnit in mobileUnits!) {
        var data = MobileUnitModel.fromJson(mobileUnit);
        mobileUnitsList.add(MobileUnitModel(
            id: data.id,
            name: utf8.decode(latin1.encode(data.name)),
            amount: data.amount));
      }
      setUserMetadata(
        firstName: response.data!.user!.userMetadata['firstName'],
        lastName: response.data!.user!.userMetadata['lastName'],
        taxId: response.data!.user!.userMetadata['taxId'],
        hospitalUnits: hospitalUnitsList.isNotEmpty ? hospitalUnitsList : null,
        mobileUnits: mobileUnitsList.isNotEmpty ? mobileUnitsList : null,
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
    var response = await _authenticationService.logout();
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
