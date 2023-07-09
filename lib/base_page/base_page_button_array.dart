// Import external packages.
import 'package:flutter/material.dart';
import 'package:kar_kam/base_page/base_page.dart';
import 'package:kar_kam/base_page/base_page_route_map.dart';

// Import project-specific files.
import 'package:kar_kam/base_page/base_page_specs.dart';

class BasePageButtonArray extends StatelessWidget {
  const BasePageButtonArray({super.key, required this.basePageSpecs});

  /// Defines the current UI layout, including specs for [BasePageButtonArray].
  final BasePageSpecs basePageSpecs;

  @override
  Widget build(BuildContext context) {
    List<Widget> fabArray = [];

    List<String>? floatingActionButtonTargetList =
        basePageSpecs.floatingActionButtonTargetList;

    if (floatingActionButtonTargetList is List<String>) {
      for (final string in floatingActionButtonTargetList) {
        fabArray.add(
          FloatingActionButton(
            heroTag: null,
            child: basePageRouteMap[string]?[1],
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => BasePage(
                    basePageSpecs: basePageRouteMap[string]?[0],
                  ),
                ),
              );
            },
          ),
        );
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      // verticalDirection: VerticalDirection.up,
      children: fabArray,
    );
  }
}
