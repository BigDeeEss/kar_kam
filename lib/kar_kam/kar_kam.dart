// Import external packages.
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

// Import project-specific files.
import 'package:kar_kam/app_data/get_it_service.dart';
import 'package:kar_kam/base_ui/base_ui.dart';
import 'package:kar_kam/kar_kam/kar_kam_ui_contents.dart';
import 'package:kar_kam/settings/settings_ui_contents.dart';



/// [KarKam] is the root widget of this application.
///
/// [KarKam] is just a [StatelessWidget] wrapper for an instance of
/// [FutureBuilder].
///
/// [FutureBuilder] implements a build dependency that sources stored app data.
class KarKam extends StatelessWidget with GetItMixin{
  KarKam({super.key});

  @override
  Widget build(BuildContext context) {
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
            // return BaseUI(baseUIContents: karKamUIContents);
            return BaseUI(baseUIContents: settingsUIContents);
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

