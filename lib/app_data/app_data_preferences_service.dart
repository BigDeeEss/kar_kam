// Import project-specific packages.
import 'package:kar_kam/app_data/app_data.dart';
import 'package:kar_kam/app_data/app_data_preferences_mixin.dart';
import 'package:kar_kam/app_data/app_data_manager_mixin.dart';
import 'package:kar_kam/app_data/get_it_service.dart';

class AppDataPreferenceService extends AppData
    with AppDataManagerMixin, AppDataPreferencesMixin {
  AppDataPreferenceService() {
    // Initialise [AppData.getMap] and [AppData.setMap].
    super.initialise();

    // Initialise [AppData.fields].
    initialise();
  }

  /// A blocking function (note the await keyword applied to [getPrefs]) that
  /// loads user preferences from file and sets null fields to default values.
  @override
  void initialise() async {
    // Apply defaults to null user preferences.
    setDefaults();

    // Load user preferences from file.
    await getPrefs();
    setPrefs();

    // Signal that [AppData.fields] are non-null.
    GetItService.signalReady<AppData>(this);
  }
}
