// Import flutter packages.
import 'package:flutter/material.dart';
import 'package:kar_kam_1/utils/data_store.dart';

/// Implements a generic page layout design.
///
/// [UI] presents a similar screenlayout for each page with:
///     1. an AppBar at the top with a title,
///     2. specific screen contents including buttons for navigation
///        and functionality, and
///     3. a bottom navigation bar.
///
///  A combination of [UI] and [_UIView] calculate [UIViewRect] which
///  represents the available screen dimensions.
class UI extends StatelessWidget {
  const UI({super.key});

  @override
  Widget build(BuildContext context) {
    // Required for calculating [UIViewRect], the available screen dimensions
    // via the use of [GlobalKeyExtension.globalPaintBounds].
    GlobalKey UIViewKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: DataStore<GlobalKey>(
        key: const ValueKey('UIViewKey'),
        data: UIViewKey,
        child: const Placeholder(),
        // child: _BasePageView(
        //   key: basePageViewKey,
        //   pageContents: pageContents,
        // ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.inversePrimary,
        height: 60.0,
      ),
    );
  }
}
