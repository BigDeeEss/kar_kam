// Import external packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/base_ui/base_ui_contents.dart';

/// Home layout.
BaseUIContents karKamUIContents = BaseUIContents(
  title: 'KarKam',
  contents: Center(
    child: FloatingActionButton(
      onPressed: (() {

      }),
    ),
  ),
  floatingActionButtonTargetList: <String>['settingsUIContents'],
);