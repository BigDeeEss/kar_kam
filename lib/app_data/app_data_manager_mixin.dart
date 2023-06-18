// Import project-specific files.
import 'package:kar_kam_1/app_data/app_data.dart';

/// Maintains [AppData].
mixin AppDataManagerMixin on AppData {
  /// Updates fields in [AppData] with [value] using [identifier] to
  /// determine which field to change
  ///
  /// [force] will cause an update regardless of h
  @override
  void update({
    bool? notify,
    required String identifier,
    var value,
  }) {
    // Get current value, and if null, set it to [value].
    getMap?[identifier] ?? setMap?[identifier]?.call(value);

    // Notify listeners only if instructed to do so. Default is NOT to notify.
    if (notify ?? false) {
      // If [notify] is null or false.
      notifyListeners();
    }
  }


  /// Sets [AppData] field values to defaults if null.
  ///
  /// [force] overrides existing values.
  @override
  void setDefaults({bool? force}) {
    // Set test.
    update(
      identifier: 'test',
      value: 'test default value.',
    );
  }
}