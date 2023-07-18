// Import project-specific packages.
import 'package:kar_kam/app_data/app_data.dart';
import 'package:kar_kam/app_data/app_data_preference_mixin.dart';
import 'package:kar_kam/app_data/app_data_manager_mixin.dart';
import 'package:kar_kam/utils/get_it_service.dart';

/// Implements an app data preference service.
class AppDataPreferenceService extends AppData
    with AppDataManagerMixin, AppDataPreferenceMixin {
  AppDataPreferenceService() {
    // Initialise [AppData.defaultsMap], [AppData.getMap] and [AppData.setMap].
    super.initialise();

    // Initialise all [AppData.field] values.
    initialise();
  }

  /// A blocking function (note the await keyword applied to [loadPrefs]) that
  /// loads user preferences from file and sets null fields to default values.
  @override
  void initialise() async {
    // Apply defaults to null user preferences.
    setDefaults();

    // Load user preferences from file.
    await loadPrefs();

    // Set new user preferences.
    savePrefs();

    // Signal that [AppData.fields] are non-null.
    GetItService.signalReady<AppData>(this);
  }
}
