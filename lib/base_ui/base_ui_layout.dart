// Import external packages.
import 'package:flutter/material.dart';

/// Allows for the easy referencing of page content.
class BaseUILayout {
  const BaseUILayout({
    required this.contents,
    this.fabTargetList,
    required this.title,
  });

  /// The [contents] associated with each page/route.
  final Widget contents;

  final List<String>? fabTargetList;

  /// A [title] for each page/route.
  final String title;
}