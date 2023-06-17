// Import external packages.
import 'package:kar_kam_1/app_data/get_it_service.dart';

// Import project-specific packages.
import 'package:kar_kam_1/app_data/app_data.dart';
import 'package:kar_kam_1/app_data/app_data_preferences_mixin.dart';
import 'package:kar_kam_1/app_data/app_data_manager_mixin.dart';

class AppDataPreferenceService extends AppData
    with AppDataManagerMixin, AppDataPreferencesMixin {
  AppDataPreferenceService() {
    print('1, test = $test');
    super.initialise();
    print('2, test = $test');
    initialise();
    print('3, test = $test');
  }

  /// A blocking function (note the await keyword applied to [getPrefs]) that
  /// loads user preferences from file and sets null fields to default values.
  @override
  void initialise() async {
    // Load user prefs from file.
    await getPrefs();

    // Apply defaults to null prefs.
    setDefaults();

    // Signal that all [AppData] fields are non-null.
    GetItService.signalReady<AppData>(this);
  }
}
