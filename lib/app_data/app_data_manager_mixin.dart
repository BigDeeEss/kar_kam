// Import project-specific files.
import 'package:kar_kam_1/app_data/app_data.dart';

mixin AppDataManagerMixin on AppData {
  /// Updates fields in [AppData] with [value] using [identifier] to
  /// determine which field to change.
  @override
  void change({
    bool? force,
    required String identifier,
    var value,
    bool? notify,
  }) {
    if (force ?? false) {
      // If [force] is null or false.
      setMap?[identifier]?.call(value);
    } else {
      // If [force] is true.
      getMap?[identifier] ?? setMap?[identifier]?.call(value);
    }

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
    change(
      identifier: 'test',
      value: 'test default value.',
    );
  }
}