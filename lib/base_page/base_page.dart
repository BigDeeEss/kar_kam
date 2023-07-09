// Import external packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/base_page/base_page_button_array.dart';
import 'package:kar_kam/base_page/base_page_specs.dart';
import 'package:kar_kam/utils/global_key_extension.dart';

/// Implements a generic page layout design.
///
/// [BasePage] presents a similar screen layout for each page with:
///     1. an AppBar at the top with a title,
///     2. specific screen contents including buttons for navigation
///        and functionality, and
///     3. a bottom navigation bar.
class BasePage extends StatefulWidget {
  const BasePage({
    super.key,
    required this.basePageSpecs,
  });

  /// Defines the current UI layout, including specs for buttons and specific
  /// functionality such as video capture, settings and file management.
  final BasePageSpecs basePageSpecs;

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  GlobalKey appBarKey = GlobalKey();
  GlobalKey bottomAppBarKey = GlobalKey();
  GlobalKey basePageButtonArrayKey = GlobalKey();
  
  BottomAppBar? bottomAppBar;

  /// Calculates the height of [bottomAppBar].
  double get bottomAppBarHeight {
    // [appBarKey.globalPaintBounds] is nullable so substitute 0.0 if necessary.
    return appBarKey.globalPaintBounds?.height ?? 0.0;
  }

  @override
  void initState() {
    // [_BasePageState] is built in two phases:
    //    (i) with [bottomAppBar], which is null initially, and then
    //    (ii) with [bottomAppBar] with height given by [bottomAppBarHeight].
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        bottomAppBar = BottomAppBar(
          key: bottomAppBarKey,
          height: bottomAppBarHeight,
        );
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Uses [appBarKey], [basePageButtonArrayKey] and [bottomAppBarKey].
    return Scaffold(
      appBar: AppBar(
        key: appBarKey,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: widget.basePageSpecs.titleWidget,
      ),
      body: widget.basePageSpecs.contents,
      bottomNavigationBar: bottomAppBar,
      floatingActionButton: BasePageButtonArray(
        key: basePageButtonArrayKey,
        basePageSpecs: widget.basePageSpecs,
      ),
    );
  }
}
