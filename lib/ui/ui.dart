// Import flutter packages.
import 'package:flutter/material.dart';

/// Implements a generic page layout design.
///
/// [UI] presents a similar screenlayout for each page with:
///     1. an AppBar at the top with a title,
///     2. specific screen contents including buttons for navigation
///        and functionality, and
///     3. a bottom navigation bar.
///
///  A combination of [UI] and [UIView] calculate [UIViewRect] which
///  represents the available screen dimensions.
class UI extends StatelessWidget {
  const UI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.inversePrimary,
        height: 60.0,
      ),
    );
  }
}
