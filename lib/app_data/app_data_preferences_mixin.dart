// Import external packages.
import 'package:shared_preferences/shared_preferences.dart';

// Import project-specific files.
import 'package:kar_kam_1/app_data/app_data.dart';

mixin AppDataPreferencesMixin on AppData {
  // void initialisePrefs() {
  //   test = 'Another instance of initialise.';
  // }

  /// Loads user prefs from file.
  Future<void> getPrefs() async {
    // Get an instance of [SharedPreferences] for retrieving stored data.
    final userPrefs = await SharedPreferences.getInstance();

    // Load data.
    test = userPrefs.getString('test');
  }
}