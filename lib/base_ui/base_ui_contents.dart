// Import external packages.
import 'package:flutter/material.dart';

/// Allows for the easy referencing of page content.
class BaseUIContents {
  const BaseUIContents({
    required this.contents,
    this.fabTargetList,
    required this.title,
  });

  /// The [contents] associated with each page/route.
  final List<Widget> contents;

  final List<String>? fabTargetList;

  /// A [title] for each page/route.
  final String title;
}