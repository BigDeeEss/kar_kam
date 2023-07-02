// Import project-specific files.
import 'dart:developer';
import 'package:kar_kam/app_data/app_data.dart';

/// Maintains [AppData].
mixin AppDataManagerMixin on AppData {
  /// Updates fields in [AppData] with [value] using [identifier] to
  /// determine which field to change
  @override
  void update({
    bool? notify,
    required String string,
    var value,
  }) {
    if (value != null) {
      // Set [AppData.field] identified by string to value.
      setMap?[string]?.call(value);

      // Notify listeners only if instructed to do so. Default is NOT to notify.
      if (notify ?? false) {
        // If [notify] is null or false.
        notifyListeners();
      }
    }
  }

  /// Sets [AppData] field values to defaults if null.
  void setDefaults() {
    // [defaultValues.keys] can't be null in a for-in loop.
    //
    // This check allows for the null-check operator to be used below.
    assert(defaultValues?.keys != null);

    // Iterate over elements in defaultValues and set [AppData] field values.
    //
    // The null-check operator can be used here because of the assertions in
    // the [initialise] function bound to [AppData].
    for (final string in defaultValues!.keys) {
      try {
        setMap![string]?.call(defaultValues![string]);
      } catch (_) {
        throw UnsupportedError('AppDataManagerMixin, setDefaults...setMap fail.');
      }
      // try {
      //   log('string = $string');
      //   log('getMap![string].call() = ${getMap?[string].call()}');
      //   log('defaultValues![string] = ${defaultValues![string]}');
      //   // Function func = setMap![string]!;
      //   // func(true);
      //   setMap![string]?.call(defaultValues![string]);
      //   log('string = $string');
      //   log('getMap![string].call() = ${getMap![string].call()}');
      //   log('drawLayoutBounds = $drawLayoutBounds');
      // } catch (_) {
      //   log('ERROR!');
      // }
    }
  }
}
