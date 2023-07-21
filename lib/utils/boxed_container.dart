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
class BoxedContainer extends StatelessWidget with GetItMixin {
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
  Widget build(BuildContext context) {
    // Watch for changes to [AppData.drawLayoutBounds] registered with GetIt.
    bool? drawLayoutBounds = watchOnly((AppData a) => a.drawLayoutBounds);

    // Switch control of layout bounds from drawLayoutBounds, which is intended
    // to be a global app setting, to borderWidth which is localised at the
    // point of instantiation.
    if (drawLayoutBoundsOverride && borderWidth != null) {
      drawLayoutBounds = (borderWidth! > 0.0 ? true : false);
    }

    return Container(
      alignment: alignment,
      clipBehavior: clipBehavior,
      constraints: constraints,
      decoration: decoration ??
          BoxDecoration(
            border: drawLayoutBounds!
                ? Border.all(
              width: borderWidth ?? 0.1,
              color: borderColor ?? Colors.black,
            )
                : null,
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius ?? 0.0),
            ),
            color: color,
          ),
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
























/// Implements a [Container] and draws its bounding box.
///
/// [BoxedContainer2] essentially calls an instance of [Container] with
/// a default decoration if one is not specifically given. [BoxedContainer2]
/// defaults to [Container] if [AppData.drawLayoutBounds] is false.
class BoxedContainer2 extends StatefulWidget with GetItStatefulWidgetMixin {
  BoxedContainer2({
    Key? key,
    this.alignment,
    this.borderColor = Colors.black,
    // this.borderRadius,
    this.borderWidth = 0.1,
    this.child,
    this.clipBehavior = Clip.none,
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

  // [BoxedContainer2]-specific variables.
  final Color borderColor;
  // final double? borderRadius;
  final double borderWidth;

  @override
  State<BoxedContainer2> createState() => _BoxedContainer2State();
}

class _BoxedContainer2State extends State<BoxedContainer2> with GetItStateMixin {
  // Required for establishing the bounding box for [Container] in [build].
  final GlobalKey containerKey = GlobalKey();

  // When evaluated, [containerRect] represents the layout bounds of the
  // [Container] in [build]. [containerRect] is required for positioning
  // the overlay.
  Rect? containerRect;

  // Determines whether to draw layout bounds or not; set by initState.
  bool? drawLayoutBounds = GetItService.instance<AppData>().drawLayoutBounds;

  bool? drawLayoutBoundsOld;

  // The link which connects the layers associated with
  // [CompositedTransformTarget] and [CompositedTransformFollower].
  LayerLink layerLink = LayerLink();

  // Controlled by [drawLayoutBounds], this variable controls [OverlayPortal]
  // in [build], which either shows or hides layout bounds.
  OverlayPortalController overlayPortalController = OverlayPortalController();

  @override
  void initState() {
    // Set initial state for [overlayPortalController] whilst
    // [Container] is built for the first time.
    // overlayPortalController.hide();

    // [_BoxedContainer2State] is built in two phases:
    //    (i) with [Container], using [containerKey], and then
    //    (ii) with [Container] and [OverlayPortal] showing the bounding box
    //    if requested.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        // log('_BoxedContainer2State, initState...containerRect = $containerRect');
        containerRect ??= containerKey.globalPaintBounds;
        // log('_BoxedContainer2State, initState...containerRect = $containerRect');
      });
    });
    super.initState();
  }

  /// Set [overlayPortalController].
  void setOverlayPortalController(bool bool) {
    log('_BoxedContainer2State, setOverlayPortalController...${overlayPortalController.isShowing}');
    bool ? overlayPortalController?.show() : overlayPortalController?.hide();
    log('_BoxedContainer2State, setOverlayPortalController...${overlayPortalController.isShowing}');
  }

  @override
  Widget build(BuildContext context) {
    // Watch for changes to [AppData.drawLayoutBounds] registered with GetIt.
    drawLayoutBounds = watchOnly((AppData a) => a.drawLayoutBounds);
    // log('_BoxedContainer2State, build...drawLayoutBounds = $drawLayoutBounds');
    // log('_BoxedContainer2State, build...containerRect = $containerRect');

    if (containerRect != null) {
      assert(drawLayoutBounds is bool,
          '_BoxedContainer2State, build...drawLayoutBounds is null');
      // assert(drawLayoutBoundsOld is bool,
      //     '_BoxedContainer2State, build...drawLayoutBoundsOld is null');
      if (drawLayoutBounds != drawLayoutBoundsOld) {
        drawLayoutBoundsOld = drawLayoutBounds;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setOverlayPortalController(drawLayoutBounds!);
          setState(() {
            // log('_BoxedContainer2State, build...containerRect = $containerRect');
            // containerRect ??= containerKey.globalPaintBounds;
            // log('_BoxedContainer2State, build...containerRect = $containerRect');
          });
        });
      }
      // setOverlayPortalController(drawLayoutBounds!);
      // SchedulerBinding.instance.addPostFrameCallback((_) {
      //   //yourcode
      // });
    }
    return OverlayPortal(
      controller: overlayPortalController,
      overlayChildBuilder: (BuildContext context) {
        assert(containerRect != null,
            '_BoxedContainer2State, build...containerRect is null');
        containerRect?.inflate(-widget.borderWidth);
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: widget.borderWidth,
              color: widget.borderColor,
            ),
            // color: Colors.pink,
          ),
          height: containerRect?.height,
          width: containerRect?.width,
          child: SizedBox.square(dimension: 5),
        );
      },
      child: Container(
        key: containerKey,
        alignment: widget.alignment,
        clipBehavior: widget.clipBehavior,
        color: widget.color,
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
      ),
    );
  }
}
