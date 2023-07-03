// Import external packages.
import 'package:shared_preferences/shared_preferences.dart';

// Import project-specific files.
import 'package:kar_kam/app_data/app_data.dart';

/// Loads and saves user preference data.
mixin AppDataPreferenceMixin on AppData {
  /// Loads a user preference from file.
  Future<void> loadPref(String string, [SharedPreferences? userPrefs]) async {
    // If [userPrefs] is null then get an instance of [SharedPreferences]
    // for retrieving stored data.
    userPrefs ?? await SharedPreferences.getInstance();

    // Load user preference from file and upload to [AppData].
    try {
      // Attempt to load bool from file.
      update(string: string, value: userPrefs?.getBool(string));
      return;
    } catch (_) {}
    try {
      // Attempt to load a double from file.
      update(string: string, value: userPrefs?.getDouble(string));
      return;
    } catch (_) {}
    try {
      // Attempt to load an integer from file.
      update(string: string, value: userPrefs?.getInt(string));
      return;
    } catch (_) {}
    try {
      // Attempt to load a string from file.
      update(string: string, value: userPrefs?.getString(string));
      return;
    } catch (_) {}
    try {
      // Attempt to load a list of strings from file.
      update(string: string, value: userPrefs?.getStringList(string));
      return;
    } catch (_) {}
  }

  /// Loads all user preferences from file.
  Future<void> loadPrefs() async {
    // Get an instance of [SharedPreferences] for retrieving stored data.
    final SharedPreferences userPrefs = await SharedPreferences.getInstance();

    // [setMap.keys] can't be null in a for-in loop.
    //
    // This check allows for the null-check operator to be used below.
    assert(setMap?.keys != null);

    // Iterate over keys in [setMap] and save [AppData.field] values to file.
    //
    // The null-check operator can be used here because of the assertions in
    // the [initialise] function bound to [AppData].
    for (final string in setMap!.keys) {
      loadPref(string, userPrefs);
    }
  }

  /// Save a user preference to file.
  Future<void> savePref(
      String string, var value, [SharedPreferences? userPrefs]) async {
    // If [userPrefs] is null then get an instance of [SharedPreferences]
    // for retrieving stored data.
    userPrefs ?? await SharedPreferences.getInstance();

    // Save user preference to file.
    try {
      // Attempt to save a bool to file.
      userPrefs?.setBool(string, value);
      return;
    } catch (_) {}
    try {
      // Attempt to save a double to file.
      userPrefs?.setDouble(string, value);
      return;
    } catch (_) {}
    try {
      // Attempt to save an integer to file.
      userPrefs?.setInt(string, value);
      return;
    } catch (_) {}
    try {
      // Attempt to save a string to file.
      userPrefs?.setString(string, value);
      return;
    } catch (_) {}
    try {
      // Attempt to save a list of strings to file.
      userPrefs?.setStringList(string, value);
      return;
    } catch (_) {}
    assert(false);
  }

  /// Save all user preferences to file.
  Future<void> savePrefs() async {
    // Get an instance of [SharedPreferences] for retrieving stored data.
    final SharedPreferences userPrefs = await SharedPreferences.getInstance();

    // [getMap.keys] can't be null in a for-in loop.
    //
    // This check allows for the null-check operator to be used below.
    assert(getMap?.keys != null);

    // Iterate over [getMap.keys] and save [AppData] field values to file.
    //
    // The null-check operator can be used here because of the assertions in
    // the [initialise] function bound to [AppData].
    for (final string in getMap!.keys) {
      savePref(string, getMap![string].call(), userPrefs);
    }
  }
}
