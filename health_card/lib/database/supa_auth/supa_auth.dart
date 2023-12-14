import 'package:supabase_flutter/supabase_flutter.dart';

class SupaAuth {
  final supabase = Supabase.instance.client;

  signOut() async {
    try {
      await supabase.auth.signOut();
    } on AuthException catch (e) {
      throw AuthException(e.message);
    }
  }

  register(String email, String password) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      return response;
    } on AuthException catch (e) {
      throw AuthException(e.message);
    }
  }

  login(
    String email,
    String password,
  ) async {
    print("got here in login");
    //  Email and password login
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthException catch (e) {
      throw AuthException(e.message);
    }
  }

  verfiyOTP(
    String email,
    String token,
  ) async {
    try {
      final response = await supabase.auth
          .verifyOTP(email: email, token: token, type: OtpType.signup);
      print(response);
    } on AuthException catch (e) {
      throw AuthException(e.message);
    }
  }
}
