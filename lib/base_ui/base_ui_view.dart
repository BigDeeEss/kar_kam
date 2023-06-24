// Import external packages.
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:kar_kam_1/app_data/app_data.dart';
import 'package:kar_kam_1/app_data/get_it_service.dart';
import 'package:kar_kam_1/utils/data_store.dart';
import 'package:kar_kam_1/utils/global_key_extension.dart';

/// Builds [children] in two parts in order to offer a way for widgets
/// further down the widget tree to get the available screen dimensions
/// via [key] and [GlobalKeyExtension.globalPaintBounds].
class BaseUIView extends StatefulWidget {
  const BaseUIView({
    required Key key,
    required this.children,
  }) : super(key: key);

  /// A list of widgets to build on the screen.
  final List<Widget> children;

  @override
  State<BaseUIView> createState() => _BaseUIViewState();
}

class _BaseUIViewState extends State<BaseUIView> {
  /// [children] is updated by [setState] in a post-frame callback.
  ///
  /// [children] may depend on knowledge of [baseUIViewRect] which defines the
  /// bounding box for [BaseUIView], hence the reason for the two-part build.
  List<Widget>? children;

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
      if (children == null) {
        setState(() {
          // children = widget.children;
          children = [const BaseUIViewTest()];
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: children ?? [Container()],
      ),
      bottomNavigationBar: bottomAppBar,
    );
  }
}

/// Tests whether [baseUIViewRect] can be calculated.
class BaseUIViewTest extends StatelessWidget {
  const BaseUIViewTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get [baseUIViewRect] (from [DataStore] in [BaseUI]).
    Rect? baseUIViewRect =
        DataStore.of<GlobalKey>(context, const ValueKey('baseUIViewKey'))
            .data
            .globalPaintBounds;

    assert(baseUIViewRect != null,
        'BaseUIViewTest, build...baseUIViewRect is null...');

    // Print basePageViewRect for test purposes and return [Placeholder]..
    log('BaseUIViewTest, build...basePageViewRect = $baseUIViewRect...');
    return const Placeholder();
  }
}
