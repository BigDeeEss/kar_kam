// Import external packages.
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Import project-specific files.
import 'package:kar_kam/files/files_page_specs.dart';
import 'package:kar_kam/kar_kam/kar_kam_page_specs.dart';
import 'package:kar_kam/settings/settings_page_specs.dart';

/// Specifies the target pages associated with the [FloatingActionButton]
/// list associated with [BasePage].
Map<String, List<dynamic>> basePageRouteMap = {
  'filesPageSpecs': [filesPageSpecs, const FaIcon(FontAwesomeIcons.fileVideo),],
  'karKamPageSpecs': [karKamPageSpecs, const FaIcon(FontAwesomeIcons.video)],
  'settingsPageSpecs': [settingsPageSpecs, const FaIcon(FontAwesomeIcons.gear)],
};