// Import flutter packages.
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

// Import project-specific files.
import 'package:kar_kam/app_data/app_data.dart';
import 'package:kar_kam/utils/global_key_extension.dart';

/// Draws a bounding box around it's [child].
class BoxedContainer2 extends StatefulWidget with GetItStatefulWidgetMixin {
  BoxedContainer2({
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

  // [BoxedContainer]-specific variables.
  final Color borderColor;
  final double borderWidth;
  final bool drawLayoutBoundsOverride;

  @override
  State<BoxedContainer2> createState() => _BoxedContainer2State();
}

class _BoxedContainer2State extends State<BoxedContainer2> with GetItStateMixin {
  /// The link which connects [child] and [childBorder].
  LayerLink layerLink = LayerLink();

  /// Used by [generateChildBorder] to determine the bounding box for [child].
  final GlobalKey childKey = GlobalKey();

  /// The bounding box for [child].
  CompositedTransformFollower? childBorder;

  /// [widget.child] refactored as an instance of [CompositedTransformTarget].
  CompositedTransformTarget? child;

  /// Generates [child].
  void generateChild() {
    if (widget.child != null) {
      child =  CompositedTransformTarget(
        link: layerLink,
        child: Container(
          key: childKey,
          child: widget.child,
        ),
      );
    }
  }

  /// Generates the bounding box for [child].
  void generateChildBorder(Rect? rect) {
    if (rect is Rect) {
      // Avoid creating [border] if [rect] dimensions are too small.
      if (rect.shortestSide < 2) return;

      setState(() {
        childBorder = CompositedTransformFollower(
          followerAnchor: Alignment.center,
          link: layerLink,
          targetAnchor: Alignment.center,
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

  /// Defines [child] and creates [childBorder] in a post frame callback.
  @override
  void initState() {
    // Firstly create [child] from [widget.child].
    generateChild();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Create [childBorder].
      if (child != null) {
        generateChildBorder(childKey.globalPaintBounds);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Watch for changes to [AppData.drawLayoutBounds] registered with GetIt.
    //
    // Used to triggering a rebuild whenever [AppData.drawLayoutBounds] changes.
    bool drawLayoutBounds =
        watchOnly((AppData a) => a.drawLayoutBounds) ?? false;

    // Switch control of layout bounds from [drawLayoutBounds], which is
    // intended to be a global app setting, to [drawLayoutBoundsOverride]
    // which is localised at the point of instantiation.
    drawLayoutBounds = drawLayoutBounds || widget.drawLayoutBoundsOverride;

    if (drawLayoutBounds && child != null && childBorder != null) {
      // Build [child] and [childBorder].
      return Stack(
        children: <Widget>[
          child!,
          childBorder!,
        ],
      );
    } else {
      // Only build [child].
      return Stack(
        children: <Widget>[
          child!,
        ],
      );
    }
  }
}