// Import flutter packages.
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

// Import project-specific files.
import 'package:kar_kam/app_data/app_data.dart';
import 'package:kar_kam/utils/global_key_extension.dart';

class BoxedContainer3 extends StatefulWidget with GetItStatefulWidgetMixin {
  BoxedContainer3({
    super.key,
    this.alignment,
    this.borderColor = Colors.red,
    this.borderWidth = 1.0,
    this.child,
    this.clipBehavior,
    this.color,
    this.constraints,
    this.decoration,
    this.drawLayoutBoundsOverride = false,
    this.foregroundDecoration,
    this.height,
    this.margin,
    this.padding,
    this.transform,
    this.transformAlignment,
    this.width,
    this.diagnostic = false,
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
  final bool drawLayoutBoundsOverride;

  final bool diagnostic;

  @override
  State<BoxedContainer3> createState() => _BoxedContainer3State();
}

class _BoxedContainer3State extends State<BoxedContainer3> with GetItStateMixin {
  CompositedTransformFollower? border;

  bool? borderExists;

  OverlayEntry? overlayEntry;

  // Used by [generateBorder] to determine the bounding box for [widget.child].
  final GlobalKey childKey = GlobalKey();

  // The link which connects [CompositedTransformTarget] in [build] with
  // [CompositedTransformFollower] in [generateBorder].
  LayerLink layerLink = LayerLink();

  /// Removes [overlayEntry] when widget is disposed.
  @override
  void dispose() {
    removeBorderOverlay();
    super.dispose();
  }

  /// Generates the bounding box for [widget.child]
  void generateBorder(Rect? rect) {
    if (rect is Rect) {
      // Avoid creating [border] if [borderRect] dimensions are too small.
      if (rect.shortestSide < 2) return;

      setState(() {
        border = CompositedTransformFollower(
          link: layerLink,
          child: IgnorePointer(
            ignoring: true,
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
        );
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Generate [child] bounding box characteristics if requested.
      if (widget.child != null) {
        if (widget.diagnostic) print('BoxedContainer3, PostFrameCallback...1');
        generateBorder(childKey.globalPaintBounds);

        borderExists = (border != null);
      }
    });
    super.initState();
  }

  bool get overlayShown => (overlayEntry != null);

  /// Removes [overlayEntry] and resents it to null.
  void removeBorderOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  ///
  void toggleOverlay() {
    if (overlayShown) {
      Overlay.of(context, debugRequiredFor: widget).insert(border!);
    } else {
      removeBorderOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch for changes to [AppData.drawLayoutBounds] registered with GetIt.
    bool drawLayoutBounds =
        watchOnly((AppData a) => a.drawLayoutBounds) ?? false;

    if (overlayShown != drawLayoutBounds && (borderExists ? false)) {
      toggleOverlay();
    }

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
