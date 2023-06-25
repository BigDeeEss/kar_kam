// Import external packages.
import 'package:flutter/material.dart';

/// Stores app data.
abstract class AppData extends ChangeNotifier {
  String? test;

  /// A map that relates a string representation of field to the corresponding
  /// getter. So, for instance, 'test' to 'AppData.test'.
  Map<String, dynamic>? getMap;

  /// A map that relates a string to a function that sets fields. So, for
  /// instance, 'test' to '(String? value) => test = value'.
  Map<String, Function>? setMap;

  /// Initialises [getMap] and [setMap].
  void initialise() {
    getMap = {
      'test': test,
    };

    setMap = {
      'test': (String? value) => test = value,
    };
  }

  /// Updates fields in [AppData] with [newValue] using [identifier] to
  /// determine which field to change.
  void update({
    bool? notify,
    required String string,
    var value,
  });
}
