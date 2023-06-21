import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:ppue/credentials/supabase.credentials.dart';

class AuthenticationService {
  Future<String?> singup({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    GotrueSessionResponse response =
        await SupabaseCredentials.supabaseClient.auth.signUp(email, password);

    if (response.error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cadastro realizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error!.message),
          backgroundColor: Colors.red,
        ),
      );
    }
    return null;
  }

  Future<String?> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    GotrueSessionResponse response =
        await SupabaseCredentials.supabaseClient.auth.signIn(
            email: email,
            password: password,
            options: AuthOptions(redirectTo: SupabaseCredentials.APIURL));

    if (response.error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login realizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error!.message),
          backgroundColor: Colors.red,
        ),
      );
    }
    return null;
  }

  Future<String?> logout({
    required BuildContext context,
  }) async {
    GotrueResponse response =
        await SupabaseCredentials.supabaseClient.auth.signOut();

    if (response.error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logout realizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error!.message),
          backgroundColor: Colors.red,
        ),
      );
    }
    return null;
  }
}
