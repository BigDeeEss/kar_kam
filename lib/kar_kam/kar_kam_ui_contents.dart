// Import external packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/base_page/base_page_specs.dart';

/// Home layout.
BasePageSpecs karKamUIContents = BasePageSpecs(
  title: 'KarKam',
  contents: Center(
    child: FloatingActionButton(
      onPressed: (() {

      }),
    ),
  ),
  floatingActionButtonTargetList: <String>['settingsUIContents'],
);