// Import external packages.
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:kar_kam/app_data/app_data.dart';
import 'package:kar_kam/app_data/get_it_service.dart';
import 'package:kar_kam/base_ui/base_ui.dart';
import 'package:kar_kam/base_ui/base_ui_contents.dart';
import 'package:kar_kam/base_ui/base_ui_route_map.dart';
import 'package:kar_kam/utils/boxed_container.dart';
import 'package:kar_kam/utils/data_store.dart';
import 'package:kar_kam/utils/global_key_extension.dart';

/// Builds [baseUIContents] in two parts in order to offer a way for widgets
/// further down the widget tree to get the available screen dimensions
/// via [key] and [GlobalKeyExtension.globalPaintBounds].
class BaseUIView extends StatefulWidget {
  const BaseUIView({
    required Key key,
    this.baseUIContents,
  }) : super(key: key);

  /// The UI contents for this instance of [BaseUIView].
  final BaseUIContents? baseUIContents;

  @override
  State<BaseUIView> createState() => _BaseUIViewState();
}

class _BaseUIViewState extends State<BaseUIView> {
  /// [baseUIContents] is updated with [widget.baseUIContents], if it is
  /// non-null, by [setState] in a post-frame callback.
  ///
  /// [baseUIContents] may depend on knowledge of [baseUIViewRect] which
  /// defines the bounding box for [BaseUIView], hence the the two-part build.
  BaseUIContents? baseUIContents;

  /// The available screen dimensions.
  Rect? baseUIViewRect;

  // An instance of [BottomAppBar], that is null to start with and only
  // properly instantiated within the post frame callback defined in [init].
  BottomAppBar? bottomAppBar;

  /// Calculates the height of [bottomAppBar] using [baseUIViewRect].
  double get bottomAppBarHeight {
    // [baseUIViewRect] is nullable so substitute [Rect.zero] when
    // [baseUIViewRect] is null.
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
      // bottomAppBar = BottomAppBar(
      //   color: Theme
      //       .of(context)
      //       .colorScheme
      //       .inversePrimary,
      //   height: bottomAppBarHeight,
      // );

      // // Upload [basePageViewRect] to the instance of [AppData]
      // // registered with [GetItService].
      // GetItService.instance<AppData>().update(
      //   string: 'baseUIViewRect',
      //   value: baseUIViewRect,
      //   notify: false,
      // );

      // Rebuild widget with [widget.baseUIContents]. A rebuild is necessary
      // as otherwise [bottomAppBar] will not be built.
      if (baseUIContents == null) {
        setState(() {
          baseUIContents = widget.baseUIContents;
          // baseUIContents = testBaseUIContents;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget? fab;

    if (baseUIContents != null) {
      if (baseUIContents!.floatingActionButtonTargetList != null) {
        fab = BoxedContainer(
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => BaseUI(
                    baseUIContents: routeMap[baseUIContents!.floatingActionButtonTargetList![0]],
                  ),
                ),
              );
            },
          ),
        );
      }
    }

    // A second instance of [Scaffold] purely for adding [bottomAppBar].
    return Scaffold(
      body: baseUIContents?.contents,
      bottomNavigationBar: bottomAppBar,
      floatingActionButton: fab,
    );
  }
}


/// Tests whether [baseUIViewRect] can be calculated.
BaseUIContents testBaseUIContents = BaseUIContents(
  title: 'TestBaseUIContents',
  contents: const _TestBaseUIContents(),
);


/// An example instance of [BaseUIContents] purely for test purposes.
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

    // Print [basePageViewRect] for test purposes.
    log('TestBaseUIContents, build...'
        'basePageViewRect = $baseUIViewRect...');

    // Prints some test data at the top of the UI.
    //
    return Center(
      child: Column(
        children: <Widget>[
          const Text('TestBaseUIContents'),
          Text(GetItService.instance<AppData>().testBool.toString()),
          Text(GetItService.instance<AppData>().testDouble.toString()),
          Text(GetItService.instance<AppData>().testInt.toString()),
          Text(GetItService.instance<AppData>().testString.toString()),
          Text(GetItService.instance<AppData>().testStringList.toString()),
        ],
      ),
    );
  }
}
