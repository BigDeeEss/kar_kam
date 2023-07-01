// Import external packages.
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:kar_kam/app_data/app_data.dart';
import 'package:kar_kam/app_data/get_it_service.dart';
import 'package:kar_kam/base_ui/base_ui_contents.dart';
import 'package:kar_kam/utils/boxed_container.dart';
import 'package:kar_kam/utils/data_store.dart';
import 'package:kar_kam/utils/global_key_extension.dart';

/// Builds [children] in two parts in order to offer a way for widgets
/// further down the widget tree to get the available screen dimensions
/// via [key] and [GlobalKeyExtension.globalPaintBounds].
class BaseUIView extends StatefulWidget {
  const BaseUIView({
    required Key key,
    this.baseUIContents,
  }) : super(key: key);

  /// Defines the current layout of the UI..
  final BaseUIContents? baseUIContents;

  @override
  State<BaseUIView> createState() => _BaseUIViewState();
}

class _BaseUIViewState extends State<BaseUIView> {
  /// [baseUIContents] is updated with [widget.baseUIContents], if it is non-null,
  /// by [setState] in a post-frame callback.
  ///
  /// [baseUIContents] may depend on knowledge of [baseUIViewRect] which defines
  /// the bounding box for [BaseUIView], hence the the two-part build.
  BaseUIContents? baseUIContents;

  /// The available screen dimensions.
  Rect? baseUIViewRect;

  // An instance of [BottomAppBar], that is null to start with and only
  // properly instantiated within the post frame callback defined in [init].
  BottomAppBar? bottomAppBar;

  /// Calculates the height of [bottomAppBar] using [baseUIViewRect].
  double get bottomAppBarHeight {
    // [baseUIViewRect] is nullable whereas the result from MediaQuery can't be.
    //
    // Use [Rect.zero] when [baseUIViewRect] is null.
    //
    // Note that [baseUIViewRect] does not include [bottomAppBar].
    return MediaQuery
        .of(context)
        .size
        .height - ((baseUIViewRect) ?? Rect.zero).height;
  }

  @override
  void initState() {
    // [BaseUIViewState] is built in two phases:
    //    (i) with [baseUIContents], which is null initially, and then
    //    (ii) with [baseUIContents] = [widget.baseUIContents], initiated by
    //    the following post-frame callback, and which may also be null.
    //
    // [BaseUIViewState] is built in two phases because [baseUIContents] may
    // require knowledge of the available screen dimensions which this widget
    // attempts to provide.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Calculate the available screen dimensions and store as [Rect].
      baseUIViewRect =
          DataStore
              .of<GlobalKey>(context, const ValueKey('baseUIViewKey'))
              .data
              .globalPaintBounds;

      // Instantiate [bottomAppBar] field in [BaseUIViewState].
      bottomAppBar = BottomAppBar(
        color: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        height: bottomAppBarHeight,
      );

      // // Upload [basePageViewRect] to the instance of [AppData]
      // // registered with [GetItService].
      // GetItService.instance<AppData>().update(
      //   string: 'baseUIViewRect',
      //   value: baseUIViewRect,
      //   notify: false,
      // );

      // Rebuild widget with [pageSpec.contents] instead of [Container].
      // Need to force a rebuild even if [widget.baseUIContents] is null,
      // otherwise [bottomAppBar] will not be built.
      if (baseUIContents == null) {
        setState(() {
          // baseUIContents = widget.baseUIContents;
          baseUIContents = testBaseUIContents;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    // A second instance of [Scaffold] purely for adding [bottomAppBar].
    return Scaffold(
      body: baseUIContents?.contents,
      bottomNavigationBar: bottomAppBar,
      // floatingActionButton: BoxedContainer(
      //   child: FloatingActionButton(
      //     onPressed: (() {}),
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
          onPressed: (() {}),
        ),
    );
  }
}


/// Tests whether [baseUIViewRect] can be calculated.
BaseUIContents testBaseUIContents = const BaseUIContents(
  title: 'TestBaseUIContents',
  contents: _TestBaseUIContents(),
);


/// An example [BaseUI] contents for test purposes.
/// Puts [Placeholder] on the screen and logs [baseUIViewRect].
class _TestBaseUIContents extends StatelessWidget {
  const _TestBaseUIContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get [baseUIViewRect] (from [DataStore] in [BaseUI]).
    Rect? baseUIViewRect =
        DataStore
            .of<GlobalKey>(context, const ValueKey('baseUIViewKey'))
            .data
            .globalPaintBounds;

    assert(baseUIViewRect != null,
    'TestBaseUIContents, build...baseUIViewRect is null...');

    // Print [basePageViewRect] for test purposes and return [Placeholder]..
    log('TestBaseUIContents, build...'
        'basePageViewRect = $baseUIViewRect...');

    // An example [BaseUI] contents for test purposes.
    return const Center(
      child: Text('TestBaseUIContents'),
    );
  }
}
