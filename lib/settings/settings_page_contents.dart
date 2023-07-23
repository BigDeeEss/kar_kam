// Import external packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/app_data/app_data.dart';
import 'package:kar_kam/utils/get_it_service.dart';
import 'package:kar_kam/settings/settings_page_list_tile.dart';

/// Implements a ListView.
class SettingsPageContents extends StatefulWidget {
  const SettingsPageContents({super.key});

  @override
  State<SettingsPageContents> createState() => _SettingsPageContentsState();
}

class _SettingsPageContentsState extends State<SettingsPageContents> {
  @override
  Widget build(BuildContext context) {
    List<Widget> settingsPageTileList = [
      SettingsPageListTile(
        // leading: const Icon(
        //   Icons.circle_notifications_outlined,
        // ),
        // height: 60.0,
        onTap: (() {
          // Toggle [drawLayoutBounds] variable in [AppData].
          bool drawLayoutBounds =
          GetItService.instance<AppData>().drawLayoutBounds!;
          GetItService.instance<AppData>()
              .update(string: 'drawLayoutBounds', value: !drawLayoutBounds);
        }),
        title: const Text('Click to toggle drawLayoutBounds'),
        // trailing: const Icon(
        //   Icons.circle_notifications_outlined,
        // ),
      ),
      ...List<Widget>.generate(50, (int index) {
        return SettingsPageListTile(
          // height: 60.0,
          title: Text(
            '$index. Some very, very, very, very, very, very, very, very, very, very, very, verylongtext!',
            maxLines: 1,
            softWrap: false,
          ),
        );
      })
    ];

    return ListView(
      children: settingsPageTileList,
    );
  }
}
