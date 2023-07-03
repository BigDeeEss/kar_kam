// Import external packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/base_ui/base_ui_contents.dart';
import 'package:kar_kam/kar_kam/kar_kam_ui_contents.dart';

/// Home layout.
BaseUIContents settingsUIContents = BaseUIContents(
  title: 'Settings',
  contents: Container(),
  floatingActionButtonTargetList: <String>[karKamUIContents.title],
);