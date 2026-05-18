import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/app_config.dart';

class SupabaseService {
  SupabaseService({SupabaseClient? client})
    : client =
          client ??
          SupabaseClient(AppConfig.supabaseUrl, AppConfig.supabaseAnonKey);

  final SupabaseClient client;
}
