// Import external packages.
import 'package:flutter/material.dart';

/// Stores app data.
abstract class AppData extends ChangeNotifier {
  String? test;

  Map<String, dynamic>? getMap;


  Map<String, Function>? setMap;


  /// Updates fields in [AppData] with [newValue] using [identifier] to
  /// determine which field to change.
  void change({
    required String identifier,
    var newValue,
    bool? notify,
  });

  /// Initialises [AppData] field values.
  void initialise() {
    getMap = {
      'test': test,
    };

    setMap = {
      'test': (String? value) => test = value,
    };
  }

  /// Sets [AppData] field values to defaults if null. [force] overrides
  /// existing values.
  void setDefaults({bool? force});
}