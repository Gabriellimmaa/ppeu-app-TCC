import 'package:flutter/material.dart';
import 'package:ppue/core/service/hospitalUnit.service.dart';
import 'package:ppue/models/HospitalUnit.model.dart';

class HospitalUnitNotifier extends ChangeNotifier {
  final HospitalUnitService _databaseService = HospitalUnitService();

  Future fetchAll() async {
    var data = await _databaseService.fetchAll();
    return data.map((e) => HospitalUnitModel.fromJson(e)).toList();
  }
}
