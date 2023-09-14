// Import flutter packages.
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

// Import project-specific files.
import 'package:kar_kam/app_data/app_data.dart';
import 'package:kar_kam/utils/global_key_extension.dart';


/// Implements a [Container] and draws its bounding box.
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
  State<BoxedContainer2> createState() => _BoxedContainer2State();
}

class _BoxedContainer2State extends State<BoxedContainer2> with GetItStateMixin {
  // The link which connects the layers associated with
  LayerLink layerLink = LayerLink();

  // Used by [addBorder] for determining the bounding box for [widget.child].
  final GlobalKey childKey = GlobalKey();

  CompositedTransformFollower? border;
  // bool drawLayoutBounds = false;

  void generateBorder(Rect? rect) {
    if (rect is Rect) {
      // Avoid creating [border] if [borderRect] dimensions are too small.
      if (rect.shortestSide < 2) return;

      print('rect = $rect');

      // print('generateBorder, border = $border');
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
      // Get [child] bounding box characteristics if requested.
      // print(drawLayoutBounds);
      if (widget.child != null) {
        // print('border1, childKey = $border, $childKey');
        if (widget.diagnostic) print('BoxedContainer2, PostFrameCallback...1');
        generateBorder(childKey.globalPaintBounds);
        // print('border2, childKey = $border, $childKey');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Watch for changes to [AppData.drawLayoutBounds] registered with GetIt.
    bool drawLayoutBounds =
        watchOnly((AppData a) => a.drawLayoutBounds) ?? false;

    // Switch control of layout bounds from [drawLayoutBounds], which is
    // intended to be a global app setting, to [drawLayoutBoundsOverride]
    // which is localised at the point of instantiation.
    drawLayoutBounds = drawLayoutBounds || widget.drawLayoutBoundsOverride;

    // print('childKey = $childKey');
    // print('childKey.globalPaintBounds = ${childKey.globalPaintBounds}');
    // print('border = $border');
    if (widget.diagnostic) print('BoxedContainer2, build...drawLayoutBounds = $drawLayoutBounds');
    if (widget.diagnostic) print('BoxedContainer2, build...border = $border');
    return Container(
      child: Stack(
        children: <Widget>[
          CompositedTransformTarget(
            link: layerLink,
            child: Container(
              key: childKey,
              child: widget.child,
            ),
          ),
          drawLayoutBounds ? (border ?? Container()) : Container(),
          // CompositedTransformFollower(
          //   link: layerLink,
          //   child: IgnorePointer(
          //     ignoring: true,
          //     child: Positioned.fromRect(
          //       rect: childKey.globalPaintBounds!,
          //       child: drawLayoutBounds ? Container(
          //           decoration: BoxDecoration(
          //             border: Border.all(
          //               width: widget.borderWidth,
          //               color: widget.borderColor,
          //             ),
          //             color: widget.color,
          //           ),
          //           height: childKey.globalPaintBounds?.height,
          //           width: childKey.globalPaintBounds?.width
          //       ) : Container(),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}