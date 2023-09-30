// Import external packages.
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

// Import project-specific files.
import 'package:kar_kam/app_data/app_data.dart';
import 'package:kar_kam/utils/get_it_service.dart';
import 'package:kar_kam/settings/settings_page_list_tile.dart';

/// Implements the ability for the user to change [AppData].
class SettingsPageContents extends StatelessWidget with GetItMixin {
  SettingsPageContents({super.key});
  @override
  Widget build(BuildContext context) {
    List<Widget> settingsPageTileList = [
      ...List<Widget>.generate(25, (int index) {
        return Text('Container #$index');
      }),
      SettingsPageListTile(
        // leading: const Icon(
        //   Icons.circle_notifications_outlined,
        // ),
        height: 60.0,
        onTap: (() {
          // Toggle [drawLayoutBounds] variable in [AppData].
          bool drawLayoutBounds =
          GetItService
              .instance<AppData>()
              .drawLayoutBounds!;
          GetItService.instance<AppData>()
              .update(string: 'drawLayoutBounds', value: !drawLayoutBounds);
        }),
        title: const Text('Click to toggle drawLayoutBounds'),
        // trailing: const Icon(
        //   Icons.circle_notifications_outlined,
        // ),
      ),
      ...List<Widget>.generate(45, (int index) {
        return Container(
          child: Text('Container #${index + 20}'),
        );
      }),
    ];

    return ListView(
      children: settingsPageTileList,
    );
  }
}
