// Import external packages.
import 'package:flutter/material.dart';

/// Allows for the easy referencing of page content.
class BaseUILayout {
  const BaseUILayout({
    required this.title,
    required this.contents,
  });

  /// A [title] for each page/route.
  final String title;

  /// The [contents] associated with each page/route.
  final Widget contents;
}