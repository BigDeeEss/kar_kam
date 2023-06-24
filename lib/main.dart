
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

// Import project-specific files.
import 'package:kar_kam/app_data/app_data.dart';
import 'package:kar_kam/app_data/app_data_preferences_service.dart';
import 'package:kar_kam/app_data/get_it_service.dart';
import 'package:kar_kam/base_ui/base_ui.dart';

/// App start point.
void main() {
  // // Avoids 'The "instance" getter on the ServicesBinding binding mixin
  // // is only available once that binding has been initialized.' error.
  // WidgetsFlutterBinding.ensureInitialized();
  //
  // // Use [GetItService] as the single point of access to [GetIt] and
  // // register an instance of [AppDataPreferenceService].
  // //
  // // The constructor for [AppDataPreferenceService] loads preferences from
  // // file and/or applies defaults.
  // GetItService.register<AppData>(AppDataPreferenceService());

  // Run the app.
  runApp(KarKam());
}


/// [KarKam] is the root widget of this application.
///
/// [KarKam] is just a [StatelessWidget] wrapper for an instance of
/// [FutureBuilder]. This implements a build dependency on the load of app
/// data from fil.
class KarKam extends StatelessWidget with GetItMixin{
  KarKam({super.key});

  @override
  Widget build(BuildContext context) {
    GetItService.register<AppData>(AppDataPreferenceService());

    return MaterialApp(
      title: 'Kar Kam',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<void>(
        future: GetItService.allReady(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // For the 'has data' case, when the load of app settings
            // is complete, continue with building BasePage.
            return const BaseUI();
          } else {
            // For the 'has no data' case, where the load of app settings
            // is still in progress, present a progress indicator.
            return const Column(
              // ToDo: Create screen contents for when initialising add data.
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Initialising Kar Kam...',),
                SizedBox(height: 16,),
                CircularProgressIndicator(),
              ],
            );
          }
        },
      ),
    );
  }
}

