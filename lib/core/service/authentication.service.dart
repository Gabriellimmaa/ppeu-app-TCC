import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:ppue/credentials/supabase.credentials.dart';

class AuthenticationService {
  Future<GotrueSessionResponse> singup({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String taxId,
  }) async {
    GotrueSessionResponse response =
        await SupabaseCredentials.supabaseClient.auth.signUp(
      email,
      password,
      userMetadata: {
        'name': name,
        'taxId': taxId,
      },
    );
    return response;
  }

  Future<GotrueSessionResponse> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    GotrueSessionResponse response = await SupabaseCredentials
        .supabaseClient.auth
        .signIn(email: email, password: password);

    return response;
  }

  Future<GotrueResponse> logout({
    required BuildContext context,
  }) async {
    GotrueResponse response =
        await SupabaseCredentials.supabaseClient.auth.signOut();

    return response;
  }
}
