// Import external packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/base_page/base_page.dart';
import 'package:kar_kam/base_page/base_page_route_map.dart';
import 'package:kar_kam/utils/bboxed_container.dart';
import 'package:kar_kam/utils/boxed_container.dart';

class BasePageButtonArray extends StatelessWidget {
  const BasePageButtonArray({
    super.key,
    required this.buttonArrayTargetList,
  });

  /// Defines page transitions for each button in [BasePageButtonArray].
  final List<String> buttonArrayTargetList;

  @override
  Widget build(BuildContext context) {
    // Generate an iterable using [Iterable.generate()].
    Iterable<Widget> buttonArray =
        Iterable.generate(buttonArrayTargetList.length, (index) {
      return BoxedContainer(
        child: FloatingActionButton(
          heroTag: null,
      child: basePageRouteMap[buttonArrayTargetList[index]]?[1],
          onPressed: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => BasePage(
              basePageSpecs: basePageRouteMap[buttonArrayTargetList[index]]
              ?[0],
            ),
          ),
        );
      },
          ),
      );
    });

    // Convert to an instance of [Column] using [intersperseWithSizedBox].
    return BBoxedContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        // verticalDirection: VerticalDirection.up,
        children: intersperseWithSizedBox(buttonArray).toList(),
      ),
    );
  }

  /// Inserts a [SizedBox] between each element of [iterable].
  /// Code modifies https://pub.dev/packages/intersperse/versions.
  Iterable<Widget> intersperseWithSizedBox(Iterable<Widget> iterable) sync* {
    final iterator = iterable.iterator;
    if (iterator.moveNext()) {
      yield iterator.current;
      while (iterator.moveNext()) {
        yield const SizedBox.square(dimension: 20.0);
        yield iterator.current;
      }
    }
  }
}
