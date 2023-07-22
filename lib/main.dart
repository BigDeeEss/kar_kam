// Import external packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/app_data/app_data.dart';
import 'package:kar_kam/app_data/app_data_preference_service.dart';
import 'package:kar_kam/utils/get_it_service.dart';
import 'package:kar_kam/kar_kam/kar_kam.dart';

/// App start point.
void main() {
  // Avoids the error with message: 'The "instance" getter on the
  // ServicesBinding binding mixin is only available once that binding
  // has been initialized.'
  //
  // Required by [shared_preferences].
  WidgetsFlutterBinding.ensureInitialized();

  // Use [GetItService] as the single point of access to [GetIt] and
  // register an instance of [AppData] using the extension,
  // [AppDataPreferenceService].
  //
  // The constructor for [AppDataPreferenceService] loads preferences from
  // file and/or applies defaults.
  //
  // Note, it is possible to move the below call to within [build] in [Kar_Kam],
  // but this doesn't support Hot Restart when connected to the SM A526B device.
  GetItService.register<AppData>(AppDataPreferenceService());

  // Run the app.
  runApp(KarKam());
}

