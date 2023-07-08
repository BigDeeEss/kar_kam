
// Import project-specific files.
import 'package:kar_kam/base_page/base_page_specs.dart';
import 'package:kar_kam/files/files_page_specs.dart';
import 'package:kar_kam/kar_kam/kar_kam_page_specs.dart';
import 'package:kar_kam/settings/settings_page_specs.dart';

/// Specifies the target pages associated with the [FloatingActionButton]
/// list associated with [BasePage].
Map<String, BasePageSpecs> basePageRouteMap = {
  'filesPageSpecs': filesPageSpecs,
  'karKamPageSpecs': karKamPageSpecs,
  'settingsPageSpecs': settingsPageSpecs,
};