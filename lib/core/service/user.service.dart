import 'package:ppue/credentials/supabase.credentials.dart';

class UserService {
  Future fetchAll() async {
    try {
      var response = await SupabaseCredentials.supabaseClient
          .from('users')
          .select()
          .execute();

      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }

  Future filterByHospitalUnit({
    required int id,
  }) async {
    try {
      var response = await SupabaseCredentials.supabaseClient
          .from('users')
          .select()
          .eq('hospitalUnit', id)
          .execute();
      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }
}
