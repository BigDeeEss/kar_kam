// Import external packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/base_ui/base_ui_contents.dart';

/// Home layout.
BaseUIContents settingsUIContents = BaseUIContents(
  title: 'Settings',
  contents: _SettingsUIContents(),
  floatingActionButtonTargetList: <String>['karKamUIContents'],
);


class _SettingsUIContents extends StatefulWidget {
  const _SettingsUIContents({super.key});

  @override
  State<_SettingsUIContents> createState() => _SettingsUIContentsState();
}

class _SettingsUIContentsState extends State<_SettingsUIContents> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
