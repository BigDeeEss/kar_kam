// Import external packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/base_page/base_page_specs.dart';

/// Home layout.
BasePageSpecs karKamPageSpecs = BasePageSpecs(
  title: 'KarKam',
  contents: const Center(
    child: Text('KarKam'),
  ),
  floatingActionButtonTargetList: <String>[
    'filesPageSpecs',
    'settingsPageSpecs',
  ],
);
