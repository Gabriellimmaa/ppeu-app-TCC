import "package:supabase/supabase.dart";

class SupabaseCredentials {
  static const String APIKEY =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVucGd3cHJlbWlnaHJqbnR4aGhnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODcyODE4OTgsImV4cCI6MjAwMjg1Nzg5OH0.Edbv2iDRuXp2IhVmW_d9Q_pt0N9SEeH4t7BKpG1-2ec";
  static const String APIURL = "https://unpgwpremighrjntxhhg.supabase.co";

  static SupabaseClient supabaseClient = SupabaseClient(APIURL, APIKEY);
}
