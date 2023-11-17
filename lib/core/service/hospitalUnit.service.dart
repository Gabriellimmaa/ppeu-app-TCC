import 'package:ppeu/credentials/supabase.credentials.dart';

class HospitalUnitService {
  Future fetchAll() async {
    try {
      var response = await SupabaseCredentials.supabaseClient
          .from('hospital-unit')
          .select()
          .execute();

      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }
}
