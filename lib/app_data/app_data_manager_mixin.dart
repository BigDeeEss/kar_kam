// Import project-specific files.
import 'package:kar_kam/app_data/app_data.dart';

/// Manages the data within [AppData].
mixin AppDataManagerMixin on AppData {
  /// Updates fields in [AppData] with [value] using [string] to
  /// determine which field to change.
  @override
  void update({
    bool? notify,
    required String string,
    var value,
  }) {
    if (value != null) {
      // Set [AppData.field], identified by string, to value.
      setMap?[string]?.call(value);

      // Notify listeners only if instructed to do so. Default is to notify.
      if (notify ?? true) {
        notifyListeners();
      }
    }
  }

  /// Sets [AppData] field values to default values if null.
  void setDefaults() {
    // [defaultsMap.keys] can't be null in a for-in loop.
    //
    // This check allows for the null-check operator to be used below.
    assert(defaultsMap?.keys != null);

    // Iterate over [defaultsMap.keys] and set [AppData] field values.
    //
    // The null-check operator can be used here because of the assertions in
    // the [initialise] function bound to [AppData].
    for (final string in defaultsMap!.keys) {
      try {
        setMap![string]?.call(defaultsMap![string]);
      } catch (_) {
        throw UnsupportedError(
            'AppDataManagerMixin, setDefaults...setMap fail.');
      }
    }
  }
}
