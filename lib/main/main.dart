
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam_1/app_data/app_data.dart';
import 'package:kar_kam_1/app_data/app_data_preferences_service.dart';
import 'package:kar_kam_1/app_data/get_it_service.dart';

/// App start point.
void main() {
  // Use [GetItService] as the single point of access to [GetIt] and
  // register an instance of [AppDataPreferenceService].
  //
  // The constructor for [AppDataPreferenceService] loads preferences from
  // file and/or applies defaults.
  GetItService.register<AppData>(AppDataPreferenceService());

  // Run the app.
  runApp(KarKam());
}
