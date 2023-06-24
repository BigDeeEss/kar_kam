// Import external packages.
import 'package:shared_preferences/shared_preferences.dart';

// Import project-specific files.
import 'package:kar_kam/app_data/app_data.dart';

mixin AppDataPreferencesMixin on AppData {
  /// Loads a user preference from file.
  Future<void> getPref(String string, SharedPreferences? userPrefs) async {
    // If [userPrefs] is null then get an instance of [SharedPreferences]
    // for retrieving stored data.
    userPrefs ?? await SharedPreferences.getInstance();

    // Get user preference from file and upload to [AppData].
    try {
      // Attempt to get bool from file.
      update(string: string, value: userPrefs?.getBool(string));
      return;
    } catch (_) {}
    try {
      // Attempt to get double from file.
      update(string: string, value: userPrefs?.getDouble(string));
      return;
    } catch (_) {}
    try {
      // Attempt to get string from file.
      update(string: string, value: userPrefs?.getString(string));
      return;
    } catch (_) {}
    try {
      // Attempt to get a list of strings from file.
      update(string: string, value: userPrefs?.getStringList(string));
      return;
    } catch (_) {}
  }

  /// Loads all user preferences from file.
  // @override
  Future<void> getPrefs() async {
    // Get an instance of [SharedPreferences] for retrieving stored data.
    var userPrefs = await SharedPreferences.getInstance();

    // Load data using [getPref] and providing [userPrefs] for speed.
    getPref(
      'test',
      userPrefs,
    );
  }

  /// Save [AppData] field values (user preferences) to file.
  Future<void> setPref(
      String string, var value, SharedPreferences? userPrefs) async {
    // If [userPrefs] is null then get an instance of [SharedPreferences]
    // for retrieving stored data.
    userPrefs ?? await SharedPreferences.getInstance();

    // Load data using [getPref] and providing [userPrefs] for speed.
    userPrefs?.setString(string, value);
  }

  /// Save [AppData] field values (user preferences) to file.
  Future<void> setPrefs() async {
    // Get an instance of [SharedPreferences] for retrieving stored data.
    final SharedPreferences userPrefs = await SharedPreferences.getInstance();

    // Load data using [getPref] and providing [userPrefs] for speed.
    setPref(
      'test',
      'AppDataPreferencesMixin, setPrefs',
      userPrefs,
    );
  }
}
