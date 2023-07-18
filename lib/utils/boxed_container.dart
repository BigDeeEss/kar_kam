// Import flutter packages.
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

// Import project-specific files.
import 'package:kar_kam/app_data/app_data.dart';
import 'package:kar_kam/utils/get_it_service.dart';
import 'package:kar_kam/utils/global_key_extension.dart';

/// Implements a [Container] and draws its bounding box.
///
/// [BoxedContainer] essentially calls an instance of [Container] with
/// a default decoration if one is not specifically given. [BoxedContainer]
/// defaults to [Container] if [AppData.drawLayoutBounds] is false.
class BoxedContainer extends StatefulWidget with GetItStatefulWidgetMixin {
  BoxedContainer({
    Key? key,
    this.alignment,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.child,
    this.clipBehavior = Clip.none,
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
  }) : super(key: key);

  // [Container]-specific variables.
  final AlignmentGeometry? alignment;
  final Widget? child;
  final Clip clipBehavior;
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
  final double? borderRadius;
  final double? borderWidth;
  final bool drawLayoutBoundsOverride;

  @override
  State<BoxedContainer> createState() => _BoxedContainerState();
}

class _BoxedContainerState extends State<BoxedContainer> with GetItStateMixin {
  // Required for establishing the bounding box for [Container] in [build].
  final GlobalKey containerKey = GlobalKey();

  // When evaluated, represents the [Size] of the [Container] in [build].
  Size? containerSize;

  // The link which connects the layers associated with
  // [CompositedTransformTarget] and [CompositedTransformFollower].
  final LayerLink _layerLink = LayerLink();

  // When evaluated, overlays a bounding box over the [Container] in [build].
  OverlayEntry? overlayEntry;

  OverlayEntry? createOverlayEntry(Size? containerSize) {
    // Do nothing if [containerSize] is null.
    if (containerSize == null) {
      return null;
    }

    assert(overlayEntry == null);

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return CompositedTransformFollower(
          link: layerLink,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: widget.borderWidth ?? 0.1,
                color: widget.borderColor ?? Colors.black,
              ),
            ),
            height: containerSize.height,
            width: containerSize.width,
          ),
        );
        // return Container(
        //   decoration: BoxDecoration(
        //     border: Border.all(
        //       width: widget.borderWidth ?? 0.1,
        //       color: widget.borderColor ?? Colors.black,
        //     ),
        //   ),
        //   height: containerSize.height,
        //   width: containerSize.width,
        // );
      },
    );
  }

  // Removes [overlayEntry] when the widget is [disposed].
  @override
  void dispose() {
    removeOverlayEntry();
    super.dispose();
  }

  @override
  void initState() {
    // [_BoxedContainerState] is built in two phases:
    //    (i) with [Container], using [containerKey], and then
    //    (ii) with [Container] and an [Overlay] showing the bounding box
    //    if requested.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      containerSize = containerKey.globalPaintBounds?.size;

      if (GetItService.instance<AppData>().drawLayoutBounds ?? false) {
        setState(() {});
      }
    });
    super.initState();
  }

  // Remove [overlayEntry].
  void removeOverlayEntry() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    // Watch for changes to [AppData.drawLayoutBounds] registered with GetIt.
    bool? drawLayoutBounds = watchOnly((AppData a) => a.drawLayoutBounds);

    // Switch control of layout bounds from drawLayoutBounds, which is intended
    // to be a global app setting, to borderWidth which is localised at the
    // point of instantiation.
    if (widget.drawLayoutBoundsOverride && widget.borderWidth != null) {
      drawLayoutBounds = (widget.borderWidth! > 0.0 ? true : false);
    }

    return Container(
      key: containerKey,
      alignment: widget.alignment,
      clipBehavior: widget.clipBehavior,
      constraints: widget.constraints,
      decoration: widget.decoration,
      foregroundDecoration: widget.foregroundDecoration,
      height: widget.height,
      margin: widget.margin,
      padding: widget.padding,
      transform: widget.transform,
      transformAlignment: widget.transformAlignment,
      width: widget.width,
      child: widget.child,
    );
  }
}
