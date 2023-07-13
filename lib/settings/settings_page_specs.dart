// Import external packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/app_data/app_data.dart';
import 'package:kar_kam/app_data/get_it_service.dart';
import 'package:kar_kam/base_page/base_page_specs.dart';
import 'package:kar_kam/settings/settings_page_list_tile.dart';

/// Settings page layout specs.
BasePageSpecs settingsPageSpecs = BasePageSpecs(
  title: 'Settings',
  contents: const SettingsPageSpecs(),
  floatingActionButtonTargetList: <String>[
    'karKamPageSpecs',
    'filesPageSpecs',
  ],
);

/// Implements a ListView.
class SettingsPageSpecs extends StatefulWidget {
  const SettingsPageSpecs({super.key});

  @override
  State<SettingsPageSpecs> createState() => _SettingsPageSpecsState();
}

class _SettingsPageSpecsState extends State<SettingsPageSpecs> {
  @override
  Widget build(BuildContext context) {
    List<Widget> settingsPageTileList = [
      SettingsPageListTile(
        leading: const Icon(
          Icons.circle_notifications_outlined,
        ),
        onTap: (() {
          // Toggle [drawLayoutBounds] variable in [AppData].
          bool drawLayoutBounds =
              GetItService.instance<AppData>().drawLayoutBounds!;
          GetItService.instance<AppData>()
              .update(string: 'drawLayoutBounds', value: !drawLayoutBounds);
        }),
        title: const Text('Click to toggle drawLayoutBounds'),
        trailing: const Icon(
          Icons.circle_notifications_outlined,
        ),
      ),
      ...List<Widget>.generate(50, (int index) {
        return SettingsPageListTile(
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
