// Import flutter packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam_1/app_data/app_data.dart';
import 'package:kar_kam_1/app_data/get_it_service.dart';
import 'package:kar_kam_1/utils/data_store.dart';
import 'package:kar_kam_1/utils/global_key_extension.dart';

/// Implements a generic page layout design.
///
/// [UI] presents a similar screen layout for each page with:
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
    // Required for calculating [uIViewRect], the available screen dimensions
    // via the use of [GlobalKeyExtension.globalPaintBounds].
    GlobalKey uIViewKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: DataStore<GlobalKey>(
        key: const ValueKey('uIViewKey'),
        data: uIViewKey,
        child: _UIView(
          key: uIViewKey,
          children: const [Placeholder()],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.inversePrimary,
        height: 60.0,
      ),
    );
  }
}

/// Builds [children] in two parts in order to offer a way for widgets
/// further down the widget tree to get the available screen dimensions
/// via the [key] and [globalPaintBounds].
class _UIView extends StatefulWidget {
  const _UIView({
    required Key key,
    required this.children,
  }) : super(key: key);

  /// A list of widgets to build on the screen.
  final List<Widget> children;

  @override
  State<_UIView> createState() => _UIViewState();
}

class _UIViewState extends State<_UIView> {
  /// [children] is updated by [setState] in a post-frame callback.
  ///
  /// [children] may depend on knowledge of [uIViewRect] which defines the
  /// bounding box for [_UIView], hence the reason for the two-part build.
  List<Widget>? children;

  @override
  void initState() {
    // [_UIViewState] is built in two phases:
    //    (i) with [children] = [Container()], by the [build] method;
    //    and then
    //    (ii) with [children] = [widget.children], initiated by
    //    the following post-frame callback.
    //
    // [_UIViewState] is built in two phases because [children] may require
    // knowledge of the available screen dimensions which this widget attempts
    // to provide.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Calculate the available screen dimensions and store as [Rect].
      Rect? uIViewKeyRect =
          DataStore.of<GlobalKey>(context, const ValueKey('uIViewKey'))
              .data
              .globalPaintBounds;

      // Upload [basePageViewRect] to the instance of [AppData]
      // registered with [GetItService].
      GetItService.instance<AppData>().update(
        string: 'uIViewKeyRect',
        value: uIViewKeyRect,
        notify: false,
      );

      // Rebuild widget with [pageSpec.contents] instead of [Container].
      if (children == null) {
        setState(() {
          children = widget.children;
          // pageContents = [const BasePageViewTest()];
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
