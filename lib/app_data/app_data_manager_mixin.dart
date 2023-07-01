// Import project-specific files.
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
    // Set [AppData.field] identified by string to value.
    setMap?[string]?.call(value);

    // Notify listeners only if instructed to do so. Default is NOT to notify.
    if (notify ?? false) {
      // If [notify] is null or false.
      notifyListeners();
    }
  }

  /// Sets [AppData] field values to defaults if null.
  ///
  /// [force] overrides existing values.
  // @override
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
      setMap![string]!.call(defaultValues![string]);
    }
  }
}
