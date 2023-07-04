// Import external packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/utils/boxed_container.dart';

class SettingsUIListTile extends StatelessWidget {
  const SettingsUIListTile({
    super.key,
    this.widget,
  });

  /// A widget to display between [leading] and [trailing].
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return BoxedContainer(
      child: widget,
    );
  }
}
