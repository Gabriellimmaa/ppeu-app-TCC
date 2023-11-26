import 'package:ppeu/models/HospitalUnit.model.dart';
import 'package:ppeu/models/MobileUnit.model.dart';
import 'package:supabase/supabase.dart';
import 'package:ppeu/credentials/supabase.credentials.dart';

class AuthenticationService {
  Future<GotrueSessionResponse> singup({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String taxId,
    List<HospitalUnitModel>? hospitalUnits,
    List<MobileUnitModel>? mobileUnits,
  }) async {
    GotrueSessionResponse response =
        await SupabaseCredentials.supabaseClient.auth.signUp(
      email,
      password,
      userMetadata: {
        'firstName': firstName,
        'lastName': lastName,
        'taxId': taxId,
        'hospitalUnits': hospitalUnits,
        'mobileUnits': mobileUnits,
      },
    );
    return response;
  }

  Future<GotrueSessionResponse> login({
    required String email,
    required String password,
  }) async {
    GotrueSessionResponse response = await SupabaseCredentials
        .supabaseClient.auth
        .signIn(email: email, password: password);

    return response;
  }

  Future<GotrueResponse> logout() async {
    GotrueResponse response =
        await SupabaseCredentials.supabaseClient.auth.signOut();

    return response;
  }
}
