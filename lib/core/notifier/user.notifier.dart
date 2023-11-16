// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:ppue/core/service/user.service.dart';
import 'package:ppue/models/User.model.dart';


class UserNotifier extends ChangeNotifier {
  final UserService _databaseService = UserService();

  Future fetchAll() async {
    var data = await _databaseService.fetchAll();
    return data.map((e) => UserModel.fromJson(e)).toList();
  }

  Future filterByHospitalUnit({
    required int id,
  }) async {
    var data = await _databaseService.filterByHospitalUnit(
      id: id,
    );

    return data.map((e) => UserModel.fromJson(e)).toList();
  }
}
