
// Import project-specific files.
import 'package:kar_kam/base_page/base_page_specs.dart';
import 'package:kar_kam/kar_kam/kar_kam_ui_contents.dart';
import 'package:kar_kam/settings/settings_ui_contents.dart';

/// Specifies the target pages associated with the [FloatingActionButton]
/// list associated with [BasePage].
Map<String, BasePageSpecs> basePageRouteMap = {
  'settingsUIContents': settingsUIContents,
  'karKamUIContents': karKamUIContents,
};