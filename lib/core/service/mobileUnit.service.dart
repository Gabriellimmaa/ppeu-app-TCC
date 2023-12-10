import 'package:ppeu/credentials/supabase.credentials.dart';

class MobileUnitService {
  Future fetchAll() async {
    try {
      var response = await SupabaseCredentials.supabaseClient
          .from('mobile-unit')
          .select()
          .execute();

      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }

  Future findByName(String name) async {
    try {
      var response = await SupabaseCredentials.supabaseClient
          .from('mobile-unit')
          .select()
          .eq('name', name)
          .execute();

      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }
}
