// Import flutter packages.
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

// Import project-specific files.
import 'package:kar_kam/app_data/app_data.dart';
import 'package:kar_kam/utils/get_it_service.dart';
import 'package:kar_kam/utils/global_key_extension.dart';

class BoxedContainer4 extends StatefulWidget with GetItStatefulWidgetMixin {
  BoxedContainer4({
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
  State<BoxedContainer4> createState() => _BoxedContainer4State();
}

class _BoxedContainer4State extends State<BoxedContainer4>
    with GetItStateMixin {
  /// Used by [generateOverlayEntry] to determine the bounding box
  /// for [widget.child].
  final GlobalKey childKey = GlobalKey();

  /// The link which connects [CompositedTransformTarget] in [build] with
  /// [CompositedTransformFollower] in [overlayEntry].
  LayerLink layerLink = LayerLink();

  /// A [Container-BoxDecoration] combination which produces the border.
  OverlayEntry? overlayEntry;

  /// A record of whether the [overlayEntry] has been applied. Required for
  /// the call to [setState] in [initState].
  bool overlayEntryInPLay = false;

  // An object that displays [overlayEntry] if [drawLayoutBounds] is true.
  OverlayState? overlayState;

  /// Generates the bounding box for [widget.child]
  void generateOverlayEntry(GlobalKey key) {
    Rect? rect = key.globalPaintBounds;

    if (rect is Rect) {
      // Avoid creating [overlayEntry] if [rect] dimensions are too small.
      if (rect.shortestSide < 2) return null;

      overlayEntry = OverlayEntry(
        builder: (BuildContext context) {
          return CompositedTransformFollower(
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
        },
      );
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Generate the bounding box [overlayEntry] for [widget.child].
      if (widget.child != null) {
        generateOverlayEntry(childKey);
      }

      // Obtain a copy of [AppData.drawLayoutBounds] registered with GetIt
      // and apply [overlayEntry] if required.
      bool drawLayoutBounds = GetItService
          .instance<AppData>()
          .drawLayoutBounds ?? false;
      if (overlayEntry != null && drawLayoutBounds) {
        // Insert the [border] OverlayEntry
        overlayState = Overlay.of(context);
        overlayState?.insert(overlayEntry!);

        // Update [overlayEntryInPLay].
        setState(() {
          overlayEntryInPLay = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Watch for changes to [AppData.drawLayoutBounds] registered with GetIt.
    bool drawLayoutBounds =
        watchOnly((AppData a) => a.drawLayoutBounds) ?? false;

    if (drawLayoutBounds != overlayEntryInPLay) toggleOverlayEntry();

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
