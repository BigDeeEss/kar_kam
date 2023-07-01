// Import external packages.
import 'package:shared_preferences/shared_preferences.dart';

// Import project-specific files.
import 'package:kar_kam/app_data/app_data.dart';

mixin AppDataPreferencesMixin on AppData {
  /// Loads a user preference from file.
  Future<void> getPref(String string, [SharedPreferences? userPrefs]) async {
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
    final SharedPreferences userPrefs = await SharedPreferences.getInstance();

    // [setMap.keys] can't be null in a for-in loop.
    //
    // This check allows for the null-check operator to be used below.
    assert(setMap?.keys != null);

    // Iterate over keys in [setMap] and save [AppData] field values to file.
    //
    // The null-check operator can be used here because of the assertions in
    // the [initialise] function bound to [AppData].
    for (final string in setMap!.keys) {
      getPref(string, userPrefs);
    }

    // Load data using [getPref] and providing [userPrefs] for speed.
    getPref(
      'test',
      userPrefs,
    );
  }

  /// Save [AppData] field values (user preferences) to file.
  Future<void> setPref(
      String string, var value, [SharedPreferences? userPrefs]) async {
    // If [userPrefs] is null then get an instance of [SharedPreferences]
    // for retrieving stored data.
    userPrefs ?? await SharedPreferences.getInstance();

    // Save user preference to file.
    try {
      // Attempt to save bool to file.
      userPrefs?.setBool(string, value);
      return;
    } catch (_) {}
    try {
      // Attempt to save double to file.
      userPrefs?.setDouble(string, value);
      return;
    } catch (_) {}
    try {
      // Attempt to save string to file.
      userPrefs?.setString(string, value);
      return;
    } catch (_) {}
    try {
      // Attempt to save a list of strings to file.
      userPrefs?.setStringList(string, value);
      return;
    } catch (_) {}
  }

  /// Save [AppData] field values (user preferences) to file.
  Future<void> setPrefs() async {
    // Get an instance of [SharedPreferences] for retrieving stored data.
    final SharedPreferences userPrefs = await SharedPreferences.getInstance();

    // [getMap.keys] can't be null in a for-in loop.
    //
    // This check allows for the null-check operator to be used below.
    assert(getMap?.keys != null);

    // Iterate over keys in [getMap] and save [AppData] field values to file.
    //
    // The null-check operator can be used here because of the assertions in
    // the [initialise] function bound to [AppData].
    for (final string in getMap!.keys) {
      setPref(string, getMap![string], userPrefs);
    }
  }
}
