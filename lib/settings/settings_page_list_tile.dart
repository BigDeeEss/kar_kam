// Import external packages.
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

// Import project-specific files.
import 'package:kar_kam/app_data/app_data.dart';
import 'package:kar_kam/utils/boxed_container.dart';
import 'package:kar_kam/utils/bboxed_container.dart';

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
    double settingsPageListTileBorderWidth =
        watchOnly((AppData a) => a.settingsPageListTileBorderWidth)!;

    // Watch for changes to [AppData.buttonAlignment] registered with [GetIt].
    double settingsPageListTileRadius =
        watchOnly((AppData a) => a.settingsPageListTileRadius)!;

    return NewContainer(
      // padding: const EdgeInsets.all(5),
      height: height,
      child: InkWell(
        onTap: onTap,
        child: NewContainer(
          // borderWidth: settingsPageListTileBorderWidth,
          child: Row(
            children: <Widget>[
              NewContainer(
                child: leading,
              ),
              Expanded(
                child: NewContainer(
                  child: title,
                ),
              ),
              NewContainer(
                child: trailing,
              ),
            ],
          ),
        ),
      ),
    );
    // return BoxedContainer(
    //   borderWidth: settingsPageListTileBorderWidth,
    //   child: ListTile(
    //     leading: leading,
    //     onTap: onTap,
    //     title: title,
    //     trailing: trailing,
    //   ),
    // );
    // return BoxedContainer(
    //   child: Card(
    //     shape: RoundedRectangleBorder(
    //       // side: BorderSide(),
    //       borderRadius: BorderRadius.circular(20.0),
    //     ),
    //     child: ListTile(
    //       leading: leading,
    //       onTap: onTap,
    //       title: title,
    //       trailing: trailing,
    //     ),
    //   ),
    // );
  }
}
