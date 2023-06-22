//  Import external packages.
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

// Import project-specific files.
import 'package:kar_kam/app_data/app_data.dart';

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
      home: Center(
        child: Column(
          children: [
            Text('$testString'),
            Text('$testDouble!'),
            Text('$testInt!'),
            Text('$testBool!'),
            Text('$testStringList'),
          ]
        ),
      ),
    );
  }
}