// Import external packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/base_page/base_page_button_array.dart';
import 'package:kar_kam/base_page/base_page_specs.dart';
import 'package:kar_kam/utils/boxed_container.dart';
import 'package:kar_kam/utils/boxed_container_2.dart';
import 'package:kar_kam/utils/boxed_container_5.dart';
import 'package:kar_kam/utils/global_key_extension.dart';

/// Implements a generic page layout design.
///
/// [BasePage] presents a similar screen layout for each page with:
///     1. an AppBar at the top with a title,
///     2. specific screen contents including buttons for navigating app
///        and app functionality, and
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

  // If not null, an instance of [BottomAppBar] to include in [Scaffold].
  BottomAppBar? bottomAppBar;

  // If not null, an instance of [BasePageButtonArray] to include in [Scaffold].
  Widget? fabArray;

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
    // A copy of [widget.basePageSpecs.floatingActionButtonTargetList]
    // so that it can be promoted from [String?] to [String].
    List<String>? floatingActionButtonTargetList =
        widget.basePageSpecs.floatingActionButtonTargetList;

    if (floatingActionButtonTargetList is List<String>) {
      fabArray = BasePageButtonArray(
        key: basePageButtonArrayKey,
        buttonArrayTargetList: floatingActionButtonTargetList,
      );
    }

    // Uses [appBarKey], [basePageButtonArrayKey] and [bottomAppBarKey].
    return Scaffold(
      appBar: AppBar(
        key: appBarKey,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Container(
          child: widget.basePageSpecs.titleWidget,
        ),
      ),
      body: widget.basePageSpecs.contents,
      bottomNavigationBar: bottomAppBar,
      floatingActionButton: fabArray,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
