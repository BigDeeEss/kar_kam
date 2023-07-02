// Import external packages.
import 'dart:developer';
import 'package:flutter/foundation.dart';

/// Stores app data.
abstract class AppData extends ChangeNotifier {
  /// Whether [BoxedContainer] draws bounding boxes or not.
  bool? drawLayoutBounds;

  bool? testBool;
  double? testDouble;
  int? testInt;
  String? testString;
  List<String>? testStringList;

  /// A map that relates a string representation of a field within [AppData]
  /// to it's corresponding default value.
  Map<String, dynamic>? defaultValues;

  /// A map that relates a string representation of a field within [AppData]
  /// to the corresponding getter. So, for instance, 'test' to 'AppData.test'.
  Map<String, dynamic>? getMap;

  /// A map that relates a string representation of a field within [AppData]
  /// to a function that sets fields. So, for instance,
  /// 'test' to '(String? value) => test = value'.
  Map<String, Function>? setMap;

  /// Initialises [getMap] and [setMap].
  void initialise() {
    defaultValues = {
      'drawLayoutBounds': true,
      'testBool': true,
      'testDouble': 1.2345,
      'testInt': 12345,
      'testString': 'testString',
      'testStringList': ['testString', 'again'],
    };

    getMap = {
      'drawLayoutBounds': () => drawLayoutBounds,
      'testBool': () => testBool,
      'testDouble': () => testDouble,
      'testInt': () => testInt,
      'testString': () => testString,
      'testStringList': () => testStringList,
    };

    setMap = {
      'drawLayoutBounds': (bool? value) => drawLayoutBounds = value,
      'testBool': (bool? value) => testBool = value,
      'testDouble': (double? value) => testDouble = value,
      'testInt': (int? value) => testInt = value,
      'testString': (String? value) => testString = value,
      'testStringList': (List<String>? value) => testStringList = value,
    };

    // Check that [defaults.keys] is non-null.
    //
    // Required because [listEquals] returns true if both lists are null.
    assert(defaultValues?.keys != null);

    // Check the list of keys in [defaultValues] and [getMap] are identical.
    assert(listEquals<String>(defaultValues?.keys.toList(growable: false),
        getMap?.keys.toList(growable: false)));

    // Check the list of keys in [defaultValues] and [setMap] are identical.
    assert(listEquals<String>(defaultValues?.keys.toList(growable: false),
        setMap?.keys.toList(growable: false)));
  }

  /// Updates fields in [AppData] with [newValue] using [identifier] to
  /// determine which field to change.
  void update({
    bool? notify,
    required String string,
    var value,
  });

  void prn(String funcName) {
    log('AppData, prn, called from $funcName.');
    assert(getMap?.keys != null);
    for (final string in getMap!.keys) {
      log('AppData, prn, $string = ${getMap![string].call()}');
    }
  }
}
