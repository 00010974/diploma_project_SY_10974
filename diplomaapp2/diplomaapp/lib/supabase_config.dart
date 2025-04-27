import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://vjkgtlmnnnitbzhtvszf.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZqa2d0bG1ubm5pdGJ6aHR2c3pmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU3Mzc2NDEsImV4cCI6MjA2MTMxMzY0MX0.Q1JhGWYI9y3oB22YonWTI4CPk_-5SQ2B4m_HZc9Zn9I';

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }
}