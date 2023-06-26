// Import external packages.
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:kar_kam/app_data/app_data.dart';
import 'package:kar_kam/app_data/get_it_service.dart';
import 'package:kar_kam/base_ui/base_ui.dart';
import 'package:kar_kam/base_ui/base_ui_layout.dart';
import 'package:kar_kam/utils/data_store.dart';
import 'package:kar_kam/utils/global_key_extension.dart';

/// Builds [children] in two parts in order to offer a way for widgets
/// further down the widget tree to get the available screen dimensions
/// via [key] and [GlobalKeyExtension.globalPaintBounds].
class BaseUIView extends StatefulWidget {
  const BaseUIView({
    required Key key,
    required this.baseUILayout,
  }) : super(key: key);

  /// Defines the current layout of the UI..
  final BaseUILayout baseUILayout;

  @override
  State<BaseUIView> createState() => _BaseUIViewState();
}

class _BaseUIViewState extends State<BaseUIView> {
  /// [baseUILayout] is updated with [widget.baseUILayout] by [setState]
  /// in a post-frame callback.
  ///
  /// [baseUILayout] may depend on knowledge of [baseUIViewRect] which defines the
  /// bounding box for [BaseUIView], hence the reason for the two-part build.
  BaseUILayout? baseUILayout;

  /// The available screen dimensions.
  Rect? baseUIViewRect;

  // An instance of [BottomAppBar], that is null to start and only properly
  // instantiated within the post frame callback that is defined in [init].
  BottomAppBar? bottomAppBar;

  /// Calculates the height of [bottomAppBar] using [baseUIViewRect].
  double get bottomAppBarHeight {
    return MediaQuery.of(context).size.height - baseUIViewRect!.height;
  }

  @override
  void initState() {
    // [BaseUIViewState] is built in two phases:
    //    (i) with [children] = [Container()], by the [build] method;
    //    and then
    //    (ii) with [children] = [widget.children], initiated by
    //    the following post-frame callback.
    //
    // [BaseUIViewState] is built in two phases because [children] may require
    // knowledge of the available screen dimensions which this widget attempts
    // to provide.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Calculate the available screen dimensions and store as [Rect].
      baseUIViewRect =
          DataStore.of<GlobalKey>(context, const ValueKey('baseUIViewKey'))
              .data
              .globalPaintBounds;

      // Instantiate [bottomAppBar] field in [BaseUIViewState].
      bottomAppBar = BottomAppBar(
        color: Theme.of(context).colorScheme.inversePrimary,
        height: bottomAppBarHeight,
      );

      // Upload [basePageViewRect] to the instance of [AppData]
      // registered with [GetItService].
      GetItService.instance<AppData>().update(
        string: 'baseUIViewRect',
        value: baseUIViewRect,
        notify: false,
      );

      // Rebuild widget with [pageSpec.contents] instead of [Container].
      if (baseUILayout == null) {
        setState(() {
          // baseUILayout = baseUILayoutTest;
          baseUILayout = widget.baseUILayout;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FloatingActionButton? floatingActionButton ;
    if (baseUILayout?.fabTargetList != null) {
      floatingActionButton = FloatingActionButton(
        onPressed: (() {
          log('_BaseUIViewState, build...executing onPressed.');
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => BaseUI(
                baseUILayout: baseUILayout!.fabTargetList![0],
              ),
            ),
          );
        }),
      );
    }

    return Scaffold(
      body: baseUILayout?.contents,
      bottomNavigationBar: bottomAppBar,
      floatingActionButton: floatingActionButton,
    );
  }
}


/// Puts [Placeholder] on the screen and logs [baseUIViewRect].
class BaseUILayoutTestContents extends StatelessWidget {
  const BaseUILayoutTestContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get [baseUIViewRect] (from [DataStore] in [BaseUI]).
    Rect? baseUIViewRect =
        DataStore.of<GlobalKey>(context, const ValueKey('baseUIViewKey'))
            .data
            .globalPaintBounds;

    assert(baseUIViewRect != null,
        'BaseUILayoutTestContents, build...baseUIViewRect is null...');

    // Print basePageViewRect for test purposes and return [Placeholder]..
    log('BaseUILayoutTestContents, build...'
        'basePageViewRect = $baseUIViewRect...');
    return const Center(
      child: Text('BaseUILayoutTestContents'),
    );
  }
}

/// Tests whether [baseUIViewRect] can be calculated.
BaseUILayout baseUILayoutTest = const BaseUILayout(
  title: 'BaseUILayoutTest',
  contents: BaseUILayoutTestContents(),
);
