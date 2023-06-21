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

  Future<PostgrestResponse?> addPP({required PPModel data}) async {
    await _databaseService.addPP(data: data);
  }
}
