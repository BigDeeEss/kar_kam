// Import external packages.
import 'package:flutter/material.dart';

/// Allows for the easy referencing of page content.
class BasePageSpecs {
  BasePageSpecs({
    required this.contents,
    this.floatingActionButtonTargetList,
    required String title,
  }) : titleWidget = Text(title);

  /// The [contents] associated with each page/route.
  final Widget contents;

  /// Specifies the FABs to be sued for each page/route.
  final List<String>? floatingActionButtonTargetList;

  /// A [title] for each page/route.
  final Widget titleWidget;
}