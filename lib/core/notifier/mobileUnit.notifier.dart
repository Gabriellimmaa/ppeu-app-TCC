import 'package:flutter/material.dart';
import 'package:ppeu/core/service/mobileUnit.service.dart';
import 'package:ppeu/models/MobileUnit.model.dart';

class MobileUnitNotifier extends ChangeNotifier {
  final MobileUnitService _databaseService = MobileUnitService();

  Future<List<MobileUnitModel>> fetchAll() async {
    List<dynamic> rawData = await _databaseService.fetchAll();

    List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(rawData);

    List<MobileUnitModel> response =
        data.map((e) => MobileUnitModel.fromJson(e)).toList();
    return response;
  }

  Future<MobileUnitModel> findByName(String name) async {
    List<dynamic> rawData = await _databaseService.findByName(name);

    List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(rawData);

    MobileUnitModel response = MobileUnitModel.fromJson(data[0]);
    return response;
  }
}
