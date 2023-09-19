import 'package:ppue/credentials/supabase.credentials.dart';
import 'package:ppue/models/PP.model.dart';
import 'package:supabase/supabase.dart';

class DatabaseService {
  Future fetchPP() async {
    try {
      var response = await SupabaseCredentials.supabaseClient
          .from('pp')
          .select()
          .execute();

      print(response.data);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<PostgrestResponse?> addPP({
    required PPModel data,
  }) async {
    try {
      PostgrestResponse response = await SupabaseCredentials.supabaseClient
          .from('pp')
          .insert(data.toJson())
          .execute();
      if (response.data != null) {
        var data = response.data;
        return data;
      } else {
        print(response.error);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future filterPP({
    required String nome,
    required String responsavelRecebimentoCpf,
    required String encaminhamento,
  }) async {
    try {
      var response = await SupabaseCredentials.supabaseClient
          .from('pp')
          .select()
          .ilike('identificacao->>nome', '%$nome%')
          .eq('recomendacoes->>encaminhamento', encaminhamento)
          .eq('recomendacoes->responsavelRecebimento->>cpf',
              responsavelRecebimentoCpf)
          .execute();
      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }
}
