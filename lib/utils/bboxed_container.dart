// Import flutter packages.
// import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

// Import project-specific files.
import 'package:kar_kam/app_data/app_data.dart';

// import 'package:kar_kam/utils/get_it_service.dart';
// import 'package:kar_kam/utils/global_key_extension.dart';

/// Implements a [Container] and draws its bounding box.
class BBoxedContainer extends StatelessWidget with GetItMixin {
  BBoxedContainer({
    super.key,
    this.alignment,
    this.borderColor,
    this.borderWidth,
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
  final Color? borderColor;
  final double? borderWidth;
  final bool drawLayoutBoundsOverride;

  @override
  Widget build(BuildContext context) {
    // Watch for changes to [AppData.drawLayoutBounds] registered with GetIt.
    bool drawLayoutBounds =
        watchOnly((AppData a) => a.drawLayoutBounds ?? false);

    // Switch control of layout bounds from [drawLayoutBounds], which is
    // intended to be a global app setting, to [drawLayoutBoundsOverride]
    // which is localised at the point of instantiation.
    if (drawLayoutBoundsOverride && borderWidth != null) {
      drawLayoutBounds = (borderWidth! > 0.0 ? true : false);
    }

    return _BBoxedContainer(
      alignment: alignment,
      borderColor: borderColor,
      borderWidth: borderWidth,
      clipBehavior: clipBehavior,
      color: color,
      constraints: constraints,
      decoration: decoration,
      drawLayoutBounds: drawLayoutBounds,
      foregroundDecoration: foregroundDecoration,
      height: height,
      margin: margin,
      padding: padding,
      transform: transform,
      transformAlignment: transformAlignment,
      width: width,
      child: child,
    );
  }
}

class _BBoxedContainer extends StatefulWidget {
  const _BBoxedContainer({
    Key? key,
    this.alignment,
    this.borderColor,
    this.borderWidth,
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
  }) : super(key: key);

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
  final Color? borderColor;
  final double? borderWidth;
  final bool drawLayoutBounds;

  @override
  State<_BBoxedContainer> createState() => _BBoxedContainerState();
}

class _BBoxedContainerState extends State<_BBoxedContainer> {
  @override
  Widget build(BuildContext context) {
    return widget.child ?? Container();
  }
}
