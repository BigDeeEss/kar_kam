// Import external packages.
import 'package:shared_preferences/shared_preferences.dart';

// Import project-specific files.
import 'package:kar_kam_1/app_data/app_data.dart';

mixin AppDataPreferencesMixin on AppData {
  /// Loads a user preference from file.
  Future<void> getPref(String string, SharedPreferences? userPrefs) async {
    // If [userPrefs] is null then get an instance of [SharedPreferences]
    // for retrieving stored data.
    userPrefs ?? await SharedPreferences.getInstance();

    // Load data.
    update(string: string, value: userPrefs?.getString(string));
  }

  /// Loads all user preferences from file.
  // @override
  Future<void> getPrefs() async {
    // Get an instance of [SharedPreferences] for retrieving stored data.
    final SharedPreferences userPrefs = await SharedPreferences.getInstance();

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
