import 'package:flutter/material.dart';
import 'package:ppue/core/service/mobileUnit.service.dart';
import 'package:ppue/models/MobileUnit.model.dart';

class MobileUnitNotifier extends ChangeNotifier {
  final MobileUnitService _databaseService = MobileUnitService();

  Future fetchAll() async {
    var data = await _databaseService.fetchAll();
    return data.map((e) => MobileUnitModel.fromJson(e)).toList();
  }
}
