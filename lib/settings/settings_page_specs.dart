// Import project-specific files.
import 'package:kar_kam/base_page/base_page_specs.dart';
import 'package:kar_kam/settings/settings_page_contents.dart';

/// Settings page layout specs.
BasePageSpecs settingsPageSpecs = BasePageSpecs(
  title: 'Settings',
  contents: const SettingsPageContents(),
  floatingActionButtonTargetList: <String>[
    'karKamPageSpecs',
    'filesPageSpecs',
  ],
);
