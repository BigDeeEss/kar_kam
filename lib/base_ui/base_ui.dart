// Import external packages.
import 'dart:developer';
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/base_ui/base_ui_contents.dart';
import 'package:kar_kam/utils/boxed_container.dart';
import 'package:kar_kam/utils/global_key_extension.dart';

import 'base_ui_route_map.dart';

/// Implements a generic page layout design.
///
/// [BaseUI] presents a similar screen layout for each page with:
///     1. an AppBar at the top with a title,
///     2. specific screen contents including buttons for navigation
///        and functionality, and
///     3. a bottom navigation bar.
class BaseUI extends StatefulWidget {
  const BaseUI({
    super.key,
    this.baseUIContents,
  });

  /// Defines the current layout of the UI, including buttons for navigation
  /// and functionality and specific functionality such as video capture,
  /// settings and file management.
  final BaseUIContents? baseUIContents;

  @override
  State<BaseUI> createState() => _BaseUIState();
}

class _BaseUIState extends State<BaseUI> {
  Widget? floatingActionButton;
  GlobalKey appBarKey = GlobalKey();
  GlobalKey floatingActionButtonKey = GlobalKey();
  GlobalKey BoxedContainerKey = GlobalKey();
  BaseUIContents? baseUIContents;

  /// Calculates the height of [bottomAppBar] using [baseUIViewRect].
  double get bottomAppBarHeight {
    // [baseUIViewRect] is nullable so substitute [Rect.zero] when
    // [baseUIViewRect] is null.
    Rect rect = appBarKey.globalPaintBounds ?? Rect.zero;
    return rect.height;
  }

  @override
  void initState() {
    // [_BaseUIState] is built in two phases:
    //    (i) with [baseUIContents], which is null initially, and then
    //    (ii) with [baseUIContents] = [widget.baseUIContents], which may also
    //    be null, initiated by the following post-frame callback.
    //
    // [_BaseUIState] is built in two phases because [baseUIContents] may
    // require knowledge of the available screen dimensions which this widget
    // attempts to provide.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // floatingActionButton = BoxedContainer(
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (BuildContext context) => BaseUI(
      //             baseUIContents: routeMap[
      //                 baseUIContents!.floatingActionButtonTargetList![0]],
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // );
      if (baseUIContents == null) {
        setState(() {
          baseUIContents = widget.baseUIContents;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Required for calculating [baseUIViewRect], the available screen
    // dimensions via the use of [GlobalKeyExtension.globalPaintBounds].
    //
    // [baseUIViewRect] is calculated in [BaseUIView.initState].
    log('_BaseUIState, build...B = ${BoxedContainerKey.globalPaintBounds}');
    log('_BaseUIState, build...F = ${floatingActionButtonKey.globalPaintBounds}');
    log('_BaseUIState, build...A = ${appBarKey.globalPaintBounds}');

    return Scaffold(
      appBar: AppBar(
        key: appBarKey,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.baseUIContents?.title ?? ''),
      ),
      body: baseUIContents?.contents,
      floatingActionButton: BoxedContainer(
        key: BoxedContainerKey,
        child: FloatingActionButton(
          heroTag: baseUIContents?.floatingActionButtonTargetList![0] ?? 'test',
          key: floatingActionButtonKey,
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => BaseUI(
                  baseUIContents: routeMap[
                      baseUIContents!.floatingActionButtonTargetList![0]],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: bottomAppBarHeight,
      ),
    );
  }
}
