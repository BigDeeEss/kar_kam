// Import external packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/base_page/base_page_specs.dart';

/// Home layout.
BasePageSpecs karKamPageSpecs = BasePageSpecs(
  title: 'KarKam',
  contents: const Center(
    child: Text('KarKam'),
  ),
  floatingActionButtonTargetList: <String>[
    'filesPageSpecs',
    'settingsPageSpecs',
  ],
);

// ToDp: add [karKamPageSpecs] functionality.
class ClickableTooltipWidget extends StatefulWidget {
  const ClickableTooltipWidget({super.key});

  @override
  State<StatefulWidget> createState() => ClickableTooltipWidgetState();
}

class ClickableTooltipWidgetState extends State<ClickableTooltipWidget> {
  final OverlayPortalController _tooltipController = OverlayPortalController();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _tooltipController.toggle,
      child: DefaultTextStyle(
        style: DefaultTextStyle.of(context).style.copyWith(fontSize: 50),
        child: OverlayPortal(
          controller: _tooltipController,
          overlayChildBuilder: (BuildContext context) {
            return const Positioned(
              top: 0,
              left: 0,
              child: ColoredBox(
                color: Colors.amberAccent,
                child: Text('tooltip'),
              ),
            );
          },
          child: const Text('Press to show/hide tooltip'),
        ),
      ),
    );
  }
}
