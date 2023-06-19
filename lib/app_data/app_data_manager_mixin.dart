// Import project-specific files.
import 'package:kar_kam_1/app_data/app_data.dart';

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
    // Set test.
    update(
      string: 'test',
      value: 'test default value.',
    );
  }
}
