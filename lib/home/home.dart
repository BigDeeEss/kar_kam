// Import external packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/base_ui/base_ui_layout.dart';
import 'package:kar_kam/settings/settings.dart';

/// Home layout.
BaseUILayout home = BaseUILayout(
  title: 'Home',
  contents: Container(),
  fabTargetList: [settings],
);