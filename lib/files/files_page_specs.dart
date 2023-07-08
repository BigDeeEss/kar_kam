// Import external packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/base_page/base_page_specs.dart';

/// Home layout.
BasePageSpecs filesPageSpecs = BasePageSpecs(
  title: 'Files',
  contents: const Center(
    child: Text('Files'),
  ),
  floatingActionButtonTargetList: <String>[
    'karKamPageSpecs',
    'settingsPageSpecs',
  ],
);