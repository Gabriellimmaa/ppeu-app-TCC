// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:ppue/core/service/database.service.dart';
import 'package:ppue/models/PP.model.dart';

class DatabaseNotifier extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();

  Future fetchPP() async {
    var data = await _databaseService.fetchPP();
    return data.map((e) => PPModel.fromJson(e)).toList();
  }

  Future<List<PPModel>> fetchStartDateEndDate({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    List<dynamic> rawData = await _databaseService.fetchStartDateEndDate(
      startDate: startDate,
      endDate: endDate,
    );

    List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(rawData);

    List<PPModel> reponse = data.map((e) => PPModel.fromJson(e)).toList();
    return reponse;
  }

  Future fetchAll() async {
    var data = await _databaseService.fetchAll();
    return data.map((e) => PPModel.fromJson(e)).toList();
  }

  Future<int> fetchCountAll() async {
    var data = await _databaseService.fetchCountAll();
    return data;
  }

  Future addPP({required BuildContext context, required PPModel data}) async {
    var response = await _databaseService.addPP(context: context, data: data);
    if (!response.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PP cadastrado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      return response;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error!.message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<List<PPModel>> filterPP({
    String? nome,
    String? responsavelRecebimentoCpf,
    required String hospitalUnit,
    String? mobileUnit,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    List<dynamic> rawData = await _databaseService.filterPP(
        nome: nome,
        responsavelRecebimentoCpf: responsavelRecebimentoCpf,
        hospitalUnit: hospitalUnit,
        startDate: startDate,
        mobileUnit: mobileUnit,
        endDate: endDate);

    List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(rawData);

    List<PPModel> response = data.map((e) => PPModel.fromJson(e)).toList();

    return response;
  }

  Future filterByStatus({
    required String status,
    required String name,
    required String date,
    required String hospitalUnit,
  }) async {
    var data = await _databaseService.filterByStatus(
      status: status,
      name: name,
      date: date,
      hospitalUnit: hospitalUnit,
    );

    return data.map((e) => PPModel.fromJson(e)).toList();
  }

  Future<bool> changeStatusToConfirmed({
    required BuildContext context,
    required int id,
  }) async {
    var response = await _databaseService.changeStatusToConfirmed(
      context: context,
      id: id,
    );
    if (!response.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PP recebida com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error!.message),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }
}
