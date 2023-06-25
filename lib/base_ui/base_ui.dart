// Import external packages.
import 'dart:developer';
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/app_data/app_data.dart';
import 'package:kar_kam/app_data/get_it_service.dart';
import 'package:kar_kam/utils/data_store.dart';
import 'package:kar_kam/utils/global_key_extension.dart';

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
  const BaseUI({super.key});

  @override
  Widget build(BuildContext context) {
    // Required for calculating [baseUIViewRect], the available screen 
    // dimensions via the use of [GlobalKeyExtension.globalPaintBounds].
    GlobalKey baseUIViewKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: DataStore<GlobalKey>(
        key: const ValueKey('baseUIViewKey'),
        data: baseUIViewKey,
        child: _BaseUIView(
          key: baseUIViewKey,
          children: const [Placeholder()],
        ),
      ),
    );
  }
}

/// Builds [children] in two parts in order to offer a way for widgets
/// further down the widget tree to get the available screen dimensions
/// via [key] and [GlobalKeyExtension.globalPaintBounds].
class _BaseUIView extends StatefulWidget {
  const _BaseUIView({
    required Key key,
    required this.children,
  }) : super(key: key);

  /// A list of widgets to build on the screen.
  final List<Widget> children;

  @override
  State<_BaseUIView> createState() => _BaseUIViewState();
}

class _BaseUIViewState extends State<_BaseUIView> {
  /// [children] is updated by [setState] in a post-frame callback.
  ///
  /// [children] may depend on knowledge of [baseUIViewRect] which defines the
  /// bounding box for [_BaseUIView], hence the reason for the two-part build.
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
    // [_BaseUIViewState] is built in two phases:
    //    (i) with [children] = [Container()], by the [build] method;
    //    and then
    //    (ii) with [children] = [widget.children], initiated by
    //    the following post-frame callback.
    //
    // [_BaseUIViewState] is built in two phases because [children] may require
    // knowledge of the available screen dimensions which this widget attempts
    // to provide.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Calculate the available screen dimensions and store as [Rect].
      baseUIViewRect =
          DataStore.of<GlobalKey>(context, const ValueKey('baseUIViewKey'))
              .data
              .globalPaintBounds;

      // Instantiate [bottomAppBar] field in [_BaseUIViewState].
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
        DataStore
            .of<GlobalKey>(context, const ValueKey('baseUIViewKey'))
            .data
            .globalPaintBounds;

    assert(baseUIViewRect != null, 'BaseUIViewTest, build...baseUIViewRect is null...');

    // Print basePageViewRect for test purposes and return [Placeholder]..
    log('BaseUIViewTest, build...basePageViewRect = $baseUIViewRect...');
    return const Placeholder();
  }
}