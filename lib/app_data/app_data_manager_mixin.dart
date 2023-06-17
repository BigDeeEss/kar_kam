// Import project-specific files.
import 'package:kar_kam_1/app_data/app_data.dart';

mixin AppDataManagerMixin on AppData {
  /// Updates fields in [AppData] with [newValue] using [identifier] to
  /// determine which field to change.
  @override
  void change({
    bool? force,
    required String identifier,
    var newValue,
    bool? notify,
  }) {
    if (force ?? false) {
      setMap?[identifier]?.call(newValue);
    } else {
      getMap?[identifier] ?? setMap?[identifier]?.call(newValue);
    }

    // Notify listeners only if instructed to do so. Default is NOT to notify.
    if (notify ?? false) {
      notifyListeners();
    }
  }


  /// Sets [AppData] field values to defaults if null.
  ///
  /// [force] overrides existing values.
  @override
  void setDefaults({bool? force}) {
    change(
      identifier: 'test',
      newValue: 'test default value.',
    );
  }
}