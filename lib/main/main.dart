
import 'package:flutter/material.dart';

import 'package:kar_kam_1/app_data/get_it_service.dart';

/// App start point.
void main() {
  // Use [GetItService] as the single point of access to [GetIt] and
  // register an instance of [AppDataService].
  GetItService.register<AppData>(AppDataPreferenceService());

  // Run the app.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kar Kam',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Placeholder(),
    );
  }
}

