// Import external packages.
import 'package:flutter/material.dart';

/// Stores app data.
abstract class AppData extends ChangeNotifier {
  String? test;

  /// A map that relates a string representation of field to the corresponding
  /// getter. So, for instance, 'test' to (the value of) 'test'.
  Map<String, dynamic>? getMap;

  /// A map that relates a string to a function that sets fields. So, for
  /// instance, 'test' to '(String? value) => test = value'.
  Map<String, Function>? setMap;

  /// Updates fields in [AppData] with [newValue] using [identifier] to
  /// determine which field to change.
  void update({
    bool? notify,
    required String identifier,
    var value,
  });

  /// Initialises [getMap] and [setMap].
  void initialise() {
    getMap = {
      'test': test,
    };

    setMap = {
      'test': (String? value) => test = value,
    };
  }

  /// Sets [AppData] field values to defaults if null.
  ///
  /// [force] will override existing values.
  void setDefaults({bool? force});
}