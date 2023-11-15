import 'package:flutter/material.dart';
import 'package:ppue/core/service/hospitalUnit.service.dart';
import 'package:ppue/models/HospitalUnit.model.dart';

class HospitalUnitNotifier extends ChangeNotifier {
  final HospitalUnitService _databaseService = HospitalUnitService();

  Future<List<HospitalUnitModel>> fetchAll() async {
    List<dynamic> rawData = await _databaseService.fetchAll();

    List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(rawData);

    List<HospitalUnitModel> hospitalUnits =
        data.map((e) => HospitalUnitModel.fromJson(e)).toList();
    return hospitalUnits;
  }
}
