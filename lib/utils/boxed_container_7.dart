// Import flutter packages.
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

// Import project-specific files.
import 'package:kar_kam/app_data/app_data.dart';
import 'package:kar_kam/utils/get_it_service.dart';
import 'package:kar_kam/utils/global_key_extension.dart';

class BoxedContainer7 extends StatefulWidget with GetItStatefulWidgetMixin {
  BoxedContainer7({
    super.key,
    this.borderColor = Colors.red,
    this.borderWidth = 1.0,
    this.child,
    this.color,
  });

  // [Container]-specific variables.
  final Widget? child;
  final Color? color;

  // [NewContainer]-specific variables.
  final Color borderColor;
  final double borderWidth;

  @override
  State<BoxedContainer7> createState() => _BoxedContainer7State();
}

class _BoxedContainer7State extends State<BoxedContainer7> with GetItStateMixin {
  bool? drawLayoutBounds;

  // The link which connects the layers associated with
  LayerLink layerLink = LayerLink();

  // Used by [addBorder] for determining the bounding box for [widget.child].
  final GlobalKey childKey = GlobalKey();

  CompositedTransformFollower? border;

  Rect? childRect;

  CompositedTransformFollower? generateBorder() {
    Rect? rect = childKey.globalPaintBounds;

    if (rect is Rect && widget.child != null) {
      // Avoid creating [border] if [borderRect] dimensions are too small.
      if (rect.shortestSide < 2) return null;

      return CompositedTransformFollower(
        link: layerLink,
        // followerAnchor: Alignment.center,
        targetAnchor: Alignment.topLeft,
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
            child: Text('CompositedTransformFollower'),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Get [child] bounding box characteristics if requested.
      border = generateBorder();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Watch for changes to [AppData.drawLayoutBounds] registered with GetIt.
    bool drawLayoutBounds =
        watchOnly((AppData a) => a.drawLayoutBounds) ?? false;

    if (border == null || drawLayoutBounds) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CompositedTransformTarget(
            link: layerLink,
            child: Container(
              key: childKey,
              child: widget.child,
            ),
          ),
          Text('Marker'),
        ]
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CompositedTransformTarget(
            link: layerLink,
            child: Container(
              key: childKey,
              child: widget.child,
            ),
          ),
          border!,
          Text('Marker'),
        ]
      );
    }
  }
}
