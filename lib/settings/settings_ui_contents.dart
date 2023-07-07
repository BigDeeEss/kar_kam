// Import external packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/base_page/base_page_specs.dart';
import 'package:kar_kam/settings/settings_ui_list_tile.dart';

/// Home layout.
BasePageSpecs settingsUIContents = BasePageSpecs(
  title: 'Settings',
  contents: const _SettingsUIContents(),
  floatingActionButtonTargetList: <String>['karKamUIContents'],
);


class _SettingsUIContents extends StatefulWidget {
  const _SettingsUIContents({super.key});

  @override
  State<_SettingsUIContents> createState() => _SettingsUIContentsState();
}

class _SettingsUIContentsState extends State<_SettingsUIContents> {
  // [scrollController] is added to the [ListView] instance below in [build]
  // in order to get the scroll position [Offset] value.
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    List<Widget> settingsUITileList = [
      ...List<Widget>.generate(50, (int index) {
        return SettingsUIListTile(
          widget: Text(
            '$index. Some very, very, very, very, very, very, very, very, very, very, very, verylongtext!',
            maxLines: 1,
            softWrap: false,
          ),
        );
      })
    ];

    return ListView.builder(
      controller: scrollController,
      itemCount: settingsUITileList.length,
      itemBuilder: (context, index) {
        return settingsUITileList[index];
      },
    );
  }
}
