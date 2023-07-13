// Import external packages.
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:kar_kam/app_data/app_data.dart';

// Import project-specific files.
import 'package:kar_kam/utils/boxed_container.dart';

class SettingsPageListTile extends StatelessWidget with GetItMixin {
  SettingsPageListTile({
    super.key,
    required this.height,
    this.leading,
    this.onTap,
    this.title,
    this.trailing,
  });

  /// Height of the bounding box for [SettingsPageListTile].
  final double height;

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
    // Watch for changes to [AppData.buttonAlignment] registered with [GetIt].
    double settingsPageListTileBorderWidth =
        watchOnly((AppData a) => a.settingsPageListTileBorderWidth)!;

    // Watch for changes to [AppData.buttonAlignment] registered with [GetIt].
    double settingsPageListTileRadius =
        watchOnly((AppData a) => a.settingsPageListTileRadius)!;

    return BoxedContainer(
      padding: const EdgeInsets.all(5),
      // height: height,
      child: InkWell(
        onTap: onTap,
        child: BoxedContainer(
          borderRadius: settingsPageListTileRadius,
          borderWidth: settingsPageListTileBorderWidth,
          child: Row(
            children: <Widget>[
              BoxedContainer(
                child: leading,
              ),
              Expanded(
                child: BoxedContainer(
                  child: title,
                ),
              ),
              BoxedContainer(
                child: trailing,
              ),
            ],
          ),
        ),
      ),
    );
    return BoxedContainer(
      borderRadius: settingsPageListTileRadius,
      borderWidth: settingsPageListTileBorderWidth,
      child: ListTile(
        leading: leading,
        onTap: onTap,
        title: title,
        trailing: trailing,
      ),
    );
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
