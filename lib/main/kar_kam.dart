//  Import external packages.
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

// Import project-specific files.
import 'package:kar_kam/app_data/app_data.dart';
import 'package:kar_kam/app_data/get_it_service.dart';

class KarKam extends StatelessWidget with GetItMixin{
  KarKam({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch for changes to [AppData.test] registered with GetIt.
    String? test = watchOnly((AppData a) => a.test);

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
            return const Placeholder();
          } else {
            // For the 'has no data' case, where the load of app settings
            // is still in progress, present a progress indicator.
            return const Column(
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
