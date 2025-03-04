import 'package:flutter/material.dart';
import 'package:pick_n_pay_user/features/signin/signin_screen.dart';
import 'package:pick_n_pay_user/theme/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Supabase.initialize(
      url: 'https://vvnvlxcawxptlpdtvxln.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ2bnZseGNhd3hwdGxwZHR2eGxuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI5NDgxNDUsImV4cCI6MjA0ODUyNDE0NX0.j_rC1tVAn_UkJGUMRsFR3VPS2Sc88zhydW8yobCsHsM');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: SigninScreen(),
    );
  }
}
