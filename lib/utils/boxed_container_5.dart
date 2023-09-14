// Import flutter packages.
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

// Import project-specific files.
import 'package:kar_kam/app_data/app_data.dart';
import 'package:kar_kam/utils/global_key_extension.dart';

class BoxedContainer5 extends StatefulWidget with GetItStatefulWidgetMixin {
  BoxedContainer5({
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
  State<BoxedContainer5> createState() => _BoxedContainer5State();
}

class _BoxedContainer5State extends State<BoxedContainer5>
    with GetItStateMixin {
  @override
  Widget build(BuildContext context) {
    // Watch for changes to [AppData.drawLayoutBounds] registered with GetIt.
    bool drawLayoutBounds =
        watchOnly((AppData a) => a.drawLayoutBounds) ?? false;

    return _BoxedContainer(
      drawLayoutBounds: drawLayoutBounds,
      key: UniqueKey(),
      child: widget.child,
    );
  }
}

class _BoxedContainer extends StatefulWidget {
  const _BoxedContainer({
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
  final bool drawLayoutBounds;

  final bool diagnostic;

  @override
  State<_BoxedContainer> createState() => _BoxedContainerState();
}

class _BoxedContainerState extends State<_BoxedContainer> {
  /// Used by [generateOverlayEntry] to determine the bounding box
  /// for [widget.child].
  final GlobalKey childKey = GlobalKey();

  /// The link which connects [CompositedTransformTarget] in [build] with
  /// [CompositedTransformFollower] in [overlayEntry].
  LayerLink layerLink = LayerLink();

  /// The box associated with [BoxedContainer5].
  OverlayEntry? overlayEntry;

  /// Removes [overlayEntry] when widget is disposed.
  @override
  void dispose() {
    try {
      overlayEntry?.remove();
    } finally {
      overlayEntry = null;
    }
    super.dispose();
  }

  /// Generates the bounding box for [widget.child]
  void generateOverlayEntry() {
    Rect? rect = childKey.globalPaintBounds;

    if (rect is Rect && widget.drawLayoutBounds) {
      // Avoid creating [overlayEntry] if [rect] dimensions are too small.
      if (rect.shortestSide < 2) return;

      print('rect = $rect');

      assert(overlayEntry == null);

      overlayEntry = OverlayEntry(
        builder: (BuildContext context) {
          return CompositedTransformFollower(
            link: layerLink,
            child: IgnorePointer(
              ignoring: true,
              child: Container(
                color: Colors.deepOrange,
                height: 10,
                width: 20,
              ),
              // child: const Icon(
              //   Icons.circle_notifications_outlined,
              //   size: 50,
              // ),
              // child: SizedBox(
              //   height: 10,
              //   width: 20,
              //   child: Text('Hello'),
              //   // child: Container(
              //   //   decoration: BoxDecoration(
              //   //     border: Border.all(
              //   //       width: widget.borderWidth,
              //   //       color: widget.borderColor,
              //   //     ),
              //   //     color: widget.color,
              //   //   ),
              //   // ),
              // ),
              // child: Container(
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //       width: widget.borderWidth,
              //       color: widget.borderColor,
              //     ),
              //     // color: widget.color,
              //   ),
              //   child: SizedBox(
              //     height: 10,
              //     width: 20,
              //   ),
              // ),
              // child: Container(
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //       width: widget.borderWidth,
              //       color: widget.borderColor,
              //     ),
              //     color: widget.color,
              //   ),
              //   // height: rect.height,
              //   // width: rect.width,
              //   height: 10,
              //   width: 20,
              // ),
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
      generateOverlayEntry();
      insertOverlay();
    });
    super.initState();
  }

  void insertOverlay() {
    if (overlayEntry != null && widget.drawLayoutBounds) {
      // Add the OverlayEntry to the Overlay.
      Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
    }
  }

  @override
  Widget build(BuildContext context) {
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
