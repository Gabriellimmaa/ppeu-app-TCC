import 'package:flutter/material.dart';
import 'package:ppue/core/service/database.service.dart';
import 'package:ppue/models/PP.model.dart';
import 'package:supabase/supabase.dart';

class DatabaseNotifier extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();

  Future fetchPP() async {
    var data = await _databaseService.fetchPP();
    return data.map((e) => PPModel.fromJson(e)).toList();
  }

  Future fetchAll() async {
    var data = await _databaseService.fetchAll();
    return data.map((e) => PPModel.fromJson(e)).toList();
  }

  Future<PostgrestResponse?> addPP(
      {required BuildContext context, required PPModel data}) async {
    await _databaseService.addPP(context: context, data: data);
  }

  Future filterPP(
      {required String nome,
      required String responsavelRecebimentoCpf,
      required String encaminhamento}) async {
    var data = await _databaseService.filterPP(
        nome: nome,
        responsavelRecebimentoCpf: responsavelRecebimentoCpf,
        encaminhamento: encaminhamento);

    data.map((e) => {print(e), PPModel.fromJson(e)}).toList();

    return data.map((e) => PPModel.fromJson(e)).toList();
  }

  Future filterByStatus(
      {required String status,
      required String name,
      required String date}) async {
    var data = await _databaseService.filterByStatus(
      status: status,
      name: name,
      date: date,
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
    return response;
  }
}
