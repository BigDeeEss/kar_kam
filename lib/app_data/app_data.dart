// Import external packages.
import 'dart:developer';
import 'package:flutter/foundation.dart';

/// Stores app data.
abstract class AppData extends ChangeNotifier {
  /// Whether [BoxedContainer] draws bounding boxes or not.
  bool? drawLayoutBounds;

  /// The border width for [SettingsPageListTile].
  double? settingsPageListTileBorderWidth;

  /// Defines [SettingsPageListTile] corner radius.
  double? settingsPageListTileRadius;

  // ToDo: remove test data.
  bool? testBool;
  double? testDouble;
  int? testInt;
  String? testString;
  List<String>? testStringList;

  /// A map that relates a string representation of [AppData.field]
  /// to it's corresponding default value.
  Map<String, dynamic>? defaultsMap;

  /// A map that relates a string representation of [AppData.field]
  /// to the corresponding getter. So, for instance, 'test' to 'AppData.test'.
  Map<String, dynamic>? getMap;

  /// A map that relates a string representation of [AppData.field]
  /// to a function that sets fields. So, for instance,
  /// 'test' to '(String? value) => test = value'.
  Map<String, Function>? setMap;

  /// Initialises [getMap] and [setMap].
  void initialise() {
    // ToDo: remove references to test data.
    defaultsMap = {
      'drawLayoutBounds': true,
      'settingsPageListTileBorderWidth': 1.0,
      'settingsPageListTileRadius': 5.0,
      'testBool': true,
      'testDouble': 1.2345,
      'testInt': 12345,
      'testString': 'testString',
      'testStringList': ['testString', 'again'],
    };

    // ToDo: remove references to test data.
    getMap = {
      'drawLayoutBounds': () => drawLayoutBounds,
      'settingsPageListTileBorderWidth': () => settingsPageListTileBorderWidth,
      'settingsPageListTileRadius': () => settingsPageListTileRadius,
      'testBool': () => testBool,
      'testDouble': () => testDouble,
      'testInt': () => testInt,
      'testString': () => testString,
      'testStringList': () => testStringList,
    };

    // ToDo: remove references to test data.
    setMap = {
      'drawLayoutBounds': (bool? value) => drawLayoutBounds = value,
      'settingsPageListTileBorderWidth': (double? value) => settingsPageListTileBorderWidth = value,
      'settingsPageListTileRadius': (double? value) => settingsPageListTileRadius = value,
      'testBool': (bool? value) => testBool = value,
      'testDouble': (double? value) => testDouble = value,
      'testInt': (int? value) => testInt = value,
      'testString': (String? value) => testString = value,
      'testStringList': (List<String>? value) => testStringList = value,
    };

    // Check that [defaultsMap.keys] is non-null.
    //
    // Required because [listEquals] returns true if both lists are null.
    assert(defaultsMap?.keys != null);

    // Check the list of keys in [defaultsMap] and [getMap] are identical.
    assert(listEquals<String>(defaultsMap?.keys.toList(growable: false),
        getMap?.keys.toList(growable: false)));

    // Check the list of keys in [defaultsMap] and [setMap] are identical.
    assert(listEquals<String>(defaultsMap?.keys.toList(growable: false),
        setMap?.keys.toList(growable: false)));
  }

  /// Updates fields in [AppData] with [value] using [string] to
  /// determine which field to change.
  void update({
    bool? notify,
    required String string,
    var value,
  });

  /// A diagnostic print of all [AppData.field] values.
  void prn(String funcName) {
    // Print calling function for ease of removing debug [prn] calls.
    log('AppData, prn, called from $funcName.');

    // [getMap.keys] can't be null in a for-in loop.
    //
    // This check allows for the null-check operator to be used below.
    assert(getMap?.keys != null);

    for (final string in getMap!.keys) {
      log('AppData, prn, $string = ${getMap![string].call()}');
    }
  }
}
