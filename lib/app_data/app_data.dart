// Import external packages.
import 'dart:developer';
import 'package:flutter/foundation.dart';

/// Stores app data.
abstract class AppData extends ChangeNotifier {
  /// Whether [BoxedContainer] draws bounding boxes or not.
  bool? drawLayoutBounds;

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
    };

    getMap = {
      'drawLayoutBounds': () => drawLayoutBounds,
    };

    setMap = {
      'drawLayoutBounds': (bool? value) => drawLayoutBounds = value,
      // 'drawLayoutBounds': (bool? value) {
      //   print('setMap, value = $value');
      //   print('setMap, drawLayoutBounds = $drawLayoutBounds');
      //   drawLayoutBounds = value;
      //   print('setMap, drawLayoutBounds = $drawLayoutBounds');
      // },
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
