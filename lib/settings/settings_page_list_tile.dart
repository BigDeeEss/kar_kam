// Import external packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/utils/boxed_container.dart';

class SettingsPageListTile extends StatelessWidget {
  const SettingsPageListTile({
    super.key,
    this.leading,
    this.onTap,
    this.title,
    this.trailing,
  });

  /// A widget to display on the left within [SettingsPageListTile].
  final Widget? leading;

  /// A gesture detection callback that implements the functionality
  /// associated with [SettingsPageListTile].
  final GestureTapCallback? onTap;

  /// A widget to display on the right within [SettingsPageListTile].
  final Widget? trailing;

  /// A widget to display between [leading] and [trailing].
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return BoxedContainer(
      child: Card(
        shape: RoundedRectangleBorder(
          // side: BorderSide(),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ListTile(
          leading: leading,
          onTap: onTap,
          title: title,
          trailing: trailing,
        ),
      ),
    );
  }
}
