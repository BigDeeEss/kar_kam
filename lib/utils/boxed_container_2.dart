// Import flutter packages.
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:kar_kam/app_data/app_data.dart';

/// Implements a [Container] and draws its bounding box.
class BoxedContainer2 extends StatelessWidget with GetItMixin {
  BoxedContainer2({
    super.key,
    this.alignment,
    this.borderColor = Colors.black,
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

  // [NewContainer]-specific variables.
  final Color borderColor;
  final double borderWidth;
  final bool drawLayoutBoundsOverride;

  // The link which connects the layers associated with
  LayerLink layerLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    // Watch for changes to [AppData.drawLayoutBounds] registered with GetIt.
    bool? drawLayoutBounds =
        watchOnly((AppData a) => a.drawLayoutBounds) ?? false;

    // Switch control of layout bounds from [drawLayoutBounds], which is
    // intended to be a global app setting, to [drawLayoutBoundsOverride]
    // which is localised at the point of instantiation.
    drawLayoutBounds = drawLayoutBounds || drawLayoutBoundsOverride;

    if (drawLayoutBounds) {
      return Stack(
        children: <Widget>[
          CompositedTransformTarget(
            link: layerLink,
            child: child,
          ),
          CompositedTransformFollower(
            link: layerLink,
            child: IgnorePointer(
              ignoring: true,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: borderWidth,
                    color: borderColor,
                  ),
                  color: color,
                ),
                height: 20,
                width: 50,
              ),
            ),
          ),
        ],
      );
    } else {
      return Stack(
        children: <Widget>[child ?? Container()],
      );
      // return child ?? Container();
    }
  }
}