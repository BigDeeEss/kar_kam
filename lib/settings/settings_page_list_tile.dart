// Import external packages.
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

// Import project-specific files.
import 'package:kar_kam/app_data/app_data.dart';
import 'package:kar_kam/utils/boxed_container_2.dart';
import 'package:kar_kam/utils/boxed_container_5.dart';
import 'package:kar_kam/utils/boxed_container_6.dart';

class SettingsPageListTile extends StatelessWidget with GetItMixin {
  SettingsPageListTile({
    super.key,
    this.height,
    this.leading,
    this.onTap,
    this.title,
    this.trailing,
  });

  /// Height of the bounding box for [SettingsPageListTile].
  final double? height;

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
    double? settingsPageListTileBorderWidth =
        watchOnly((AppData a) => a.settingsPageListTileBorderWidth);

    // Watch for changes to [AppData.buttonAlignment] registered with [GetIt].
    double? settingsPageListTileRadius =
        watchOnly((AppData a) => a.settingsPageListTileRadius);

    // print('SettingsPageListTile, build...height = $height');
    // print('SettingsPageListTile, build...screen size = ${MediaQuery.of(context).size}');
    return Container(
      // diagnostic: true,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: settingsPageListTileBorderWidth ?? 0.0
          ),
          borderRadius: BorderRadius.circular(settingsPageListTileRadius ?? 0.0),
        ),
        // padding: const EdgeInsets.all(5),
        height: height,
        child: InkWell(
          onTap: onTap,
          // child: Container(
          child: BoxedContainer6(
            // borderWidth: settingsPageListTileBorderWidth,
            child: Row(
              children: <Widget>[
                Container(
                  child: leading,
                ),
                Expanded(
                  child: Container(
                    child: title,
                  ),
                ),
                Container(
                  child: trailing,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
