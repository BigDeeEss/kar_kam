// Import flutter packages.
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

// Import project-specific files.
import 'package:kar_kam/app_data/app_data.dart';
import 'package:kar_kam/utils/global_key_extension.dart';

class BoxedContainer6 extends StatefulWidget with GetItStatefulWidgetMixin {
  BoxedContainer6({
    super.key,
    this.alignment,
    this.borderColor = Colors.red,
    this.borderWidth = 1.0,
    this.child,
    this.clipBehavior,
    this.color,
    this.constraints,
    this.decoration,
    this.foregroundDecoration,
    this.height,
    this.margin,
    this.padding,
    this.transform,
    this.transformAlignment,
    this.width,
  });

  // [Container]-specific variables.
  final AlignmentGeometry? alignment;
  final Widget? child;
  final Clip? clipBehavior;
  final Color? color;
  final BoxConstraints? constraints;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final double? width;

  // [NewContainer]-specific variables.
  final Color borderColor;
  final double borderWidth;

  @override
  State<BoxedContainer6> createState() => _BoxedContainer6State();
}

class _BoxedContainer6State extends State<BoxedContainer6> with GetItStateMixin {
  @override
  Widget build(BuildContext context) {
    // Watch for changes to [AppData.drawLayoutBounds] registered with GetIt.
    bool drawLayoutBounds =
        watchOnly((AppData a) => a.drawLayoutBounds) ?? false;
    // print('_BoxedContainer6State, build...drawLayoutBounds = $drawLayoutBounds');
    return _BoxedContainer61(
      drawLayoutBounds: drawLayoutBounds,
      key: UniqueKey(),
      child: widget.child,
    );
  }
}

class _BoxedContainer61 extends StatefulWidget {
  const _BoxedContainer61({
    super.key,
    this.alignment,
    this.borderColor = Colors.red,
    this.borderWidth = 1.0,
    this.child,
    this.clipBehavior,
    this.color,
    this.constraints,
    this.decoration,
    required this.drawLayoutBounds,
    this.foregroundDecoration,
    this.height,
    this.margin,
    this.padding,
    this.transform,
    this.transformAlignment,
    this.width,
  });

  // [Container]-specific variables.
  final AlignmentGeometry? alignment;
  final Widget? child;
  final Clip? clipBehavior;
  final Color? color;
  final BoxConstraints? constraints;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final double? width;

  // [NewContainer]-specific variables.
  final Color borderColor;
  final double borderWidth;
  final bool drawLayoutBounds;

  @override
  State<_BoxedContainer61> createState() => _BoxedContainer61State();
}

class _BoxedContainer61State extends State<_BoxedContainer61> {
  /// Used by [generateOverlayEntry] to determine the bounding box
  /// for [widget.child].
  final GlobalKey childKey = GlobalKey();

  /// The link which connects [CompositedTransformTarget] in [build] with
  /// [CompositedTransformFollower] in [overlayEntry].
  LayerLink layerLink = LayerLink();

  /// A [Container-BoxDecoration] combination which produces the border.
  OverlayEntry? overlayEntry;

  /// Removes [overlayEntry] when widget is disposed.
  @override
  void dispose() {
    overlayEntry?.remove();
    overlayEntry = null;
    super.dispose();
  }

  /// Generates the bounding box for [widget.child]
  void generateOverlayEntry() {
    Rect? rect = childKey.globalPaintBounds;

    print('executing _BoxedContainer61State, generateOverlayEntry...1');

    if (rect is Rect && widget.drawLayoutBounds) {

      print('executing _BoxedContainer61State, generateOverlayEntry...2');
      // Avoid creating [overlayEntry] if [rect] dimensions are too small.
      if (rect.shortestSide < 2) return;

      print('rect = $rect');

      assert(overlayEntry == null);

      overlayEntry = OverlayEntry(
        builder: (BuildContext context) {
          return CompositedTransformFollower(
            // offset: Offset(-50,0),
            link: layerLink,
            targetAnchor: Alignment.topLeft,
            child: IgnorePointer(
              ignoring: true,
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: widget.borderWidth,
                      color: widget.borderColor,
                    ),
                    color: widget.color,
                  ),
                  height: rect.height,
                  width: rect.width,
                ),
              ),
              // c
            ),
          );
        },
      );

      // Add the OverlayEntry to the Overlay.
      Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Generate the bounding box [overlayEntry] for [widget.child].
      generateOverlayEntry();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('_BoxedContainer61State, build...childKey = $childKey');
    print('_BoxedContainer61State, build...widget.drawLayoutBounds = ${widget.drawLayoutBounds}');

  // ToDo: add Container parameters.
    return CompositedTransformTarget(
      link: layerLink,
      child: Container(
        key: childKey,
        child: widget.child,
      ),
    );
  }
}

