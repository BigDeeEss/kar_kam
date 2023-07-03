// Import external packages.
import 'package:flutter/material.dart';

/// Allows for the easy referencing of page content.
class BaseUIContents {
  const BaseUIContents({
    required this.contents,
    this.floatingActionButton,
    this.floatingActionButtonTargetList,
    required this.title,
  });

  /// The [contents] associated with each page/route.
  final Widget contents;

  /// Prototype FAB specifier.
  final List<String>? floatingActionButtonTargetList;

  final Widget? floatingActionButton;

  /// A [title] for each page/route.
  final String title;
}