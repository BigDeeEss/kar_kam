// Import external packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/base_ui/base_ui_layout.dart';
import 'package:kar_kam/home/home.dart';
import 'package:kar_kam/settings/settings.dart';

/// Implements a generic page layout design.
///
/// [BaseUI] presents a similar screen layout for each page with:
///     1. an AppBar at the top with a title,
///     2. specific screen contents including buttons for navigation
///        and functionality, and
///     3. a bottom navigation bar.
///
///  A combination of [BaseUI] and [_BaseUIView] calculate [baseUIViewRect]
///  which represents the available screen dimensions.
class BaseUI extends StatelessWidget {
  BaseUI({
    super.key,
    this.baseUILayout,
  });

  /// Defines the current layout of the UI..
  final BaseUILayout? baseUILayout;

  final Map<String, BaseUILayout> fabTargetToBaseUILayout = {
    'home': home,
    'settings': settings,
  };

  @override
  Widget build(BuildContext context) {
    // Required for calculating [baseUIViewRect], the available screen
    // dimensions via the use of [GlobalKeyExtension.globalPaintBounds].
    // GlobalKey baseUIViewKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(baseUILayout?.title ?? ''),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => BaseUI(
                baseUILayout: fabTargetToBaseUILayout[
                    baseUILayout?.fabTargetList![0].toLowerCase()],
              ),
            ),
          );
        }),
      ),
      // body: DataStore<GlobalKey>(
      //   key: const ValueKey('baseUIViewKey'),
      //   data: baseUIViewKey,
      //   child: BaseUIView(
      //     key: baseUIViewKey,
      //     baseUILayout: baseUILayout,
      //     // children: baseUISpec,
      //   ),
      // ),
    );
  }
}
