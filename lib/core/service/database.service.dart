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

  Future fetchCountAll() async {
    var response = await SupabaseCredentials.supabaseClient
        .from('pp')
        .select('*')
        .execute();

    return response.data.toList().length;
  }

  Future fetchStartDateEndDate({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    var response = await SupabaseCredentials.supabaseClient
        .from('pp')
        .select()
        .gte('created_at', startDate.toIso8601String())
        .lte('created_at', endDate.toIso8601String())
        .execute();

    return response.data;
  }

  Future<PostgrestResponse> addPP({
    required BuildContext context,
    required PPModel data,
  }) async {
    PostgrestResponse response = await SupabaseCredentials.supabaseClient
        .from('pp')
        .insert(data.toJson())
        .execute();

    final responseQueryHospital = await SupabaseCredentials.supabaseClient
        .from('hospital-unit')
        .select('amount')
        .eq('name', data.recomendacoes.encaminhamento)
        .single()
        .execute();

    await SupabaseCredentials.supabaseClient
        .from('hospital-unit')
        .update({'amount': responseQueryHospital.data['amount'] + 1})
        .eq('name', data.recomendacoes.encaminhamento)
        .execute();

    final responseQueryMobile = await SupabaseCredentials.supabaseClient
        .from('mobile-unit')
        .select('amount')
        .eq('name', data.identificacao.formaEncaminhamento)
        .single()
        .execute();

    await SupabaseCredentials.supabaseClient
        .from('mobile-unit')
        .update({'amount': responseQueryMobile.data['amount'] + 1})
        .eq('name', data.identificacao.formaEncaminhamento)
        .execute();

    return response.data;
  }

  Future<PostgrestResponse> changeStatusToConfirmed({
    required BuildContext context,
    required int id,
  }) async {
    PostgrestResponse response = await SupabaseCredentials.supabaseClient
        .from('pp')
        .update({'status': PPStatus.CONFIRMED})
        .eq('id', id)
        .execute();

    return response;
  }

  Future filterPP({
    required String nome,
    required String responsavelRecebimentoCpf,
    required String encaminhamento,
    required String date,
  }) async {
    var query = SupabaseCredentials.supabaseClient.from('pp').select();
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

    query = query
        .ilike('identificacao->>nome', '%$nome%')
        .eq('recomendacoes->>encaminhamento', encaminhamento)
        .eq('recomendacoes->responsavelRecebimento->>cpf',
            responsavelRecebimentoCpf);

    var response = await query.execute();
    return response.data;
  }

  Future filterByStatus(
      {required String status,
      required String name,
      required String date,
      required String hospitalUnit}) async {
    var query = SupabaseCredentials.supabaseClient
        .from('pp')
        .select()
        .eq('recomendacoes->>encaminhamento', hospitalUnit);

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

    var response = await query.execute();

    return response.data;
  }
}
