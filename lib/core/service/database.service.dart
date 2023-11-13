import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppue/credentials/supabase.credentials.dart';
import 'package:ppue/models/PP.model.dart';
import 'package:ppue/models/PPStatus.model.dart';
import 'package:supabase/supabase.dart';

class DatabaseService {
  Future fetchPP() async {
    var response =
        await SupabaseCredentials.supabaseClient.from('pp').select().execute();
    return response.data;
  }

  Future fetchAll() async {
    var response =
        await SupabaseCredentials.supabaseClient.from('pp').select().execute();

    return response.data;
  }

  Future<PostgrestResponse?> addPP({
    required BuildContext context,
    required PPModel data,
  }) async {
    PostgrestResponse response = await SupabaseCredentials.supabaseClient
        .from('pp')
        .insert(data.toJson())
        .execute();
    if (response.data != null) {
      var data = response.data;
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PP cadastrado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      return data;
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error!.message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<bool> changeStatusToConfirmed({
    required BuildContext context,
    required int id,
  }) async {
    PostgrestResponse response = await SupabaseCredentials.supabaseClient
        .from('pp')
        .update({'status': PPStatus.CONFIRMED})
        .eq('id', id)
        .execute();
    if (!response.hasError) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PP recebida com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      return true;
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error!.message),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }

  Future filterPP({
    required String nome,
    required String responsavelRecebimentoCpf,
    required String encaminhamento,
  }) async {
    var response = await SupabaseCredentials.supabaseClient
        .from('pp')
        .select()
        .ilike('identificacao->>nome', '%$nome%')
        .eq('recomendacoes->>encaminhamento', encaminhamento)
        .eq('recomendacoes->responsavelRecebimento->>cpf',
            responsavelRecebimentoCpf)
        .execute();
    return response.data;
  }

  Future filterByStatus({
    required String status,
    required String name,
    required String date,
  }) async {
    var query = SupabaseCredentials.supabaseClient.from('pp').select();

    if (status != 'all') {
      query = query.eq('status', status);
    }

    if (name != '') {
      query = query.ilike('identificacao->>nome', '%$name%');
    }

    if (date != '') {
      DateTime selectedDate = DateFormat("yyyy-MM-dd").parse(date);

      DateTime startDate = DateTime(
          selectedDate.year, selectedDate.month, selectedDate.day, 0, 0, 0);
      DateTime endDate = DateTime(selectedDate.year, selectedDate.month,
          selectedDate.day, 23, 59, 59, 999);

      query = query
          .gte('created_at', startDate.toIso8601String())
          .lte('created_at', endDate.toIso8601String());
    }
    print(name);
    print(status);
    print(date);
    var response = await query.execute();

    return response.data;
  }
}
