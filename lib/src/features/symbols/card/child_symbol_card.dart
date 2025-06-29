import 'package:aac/src/features/boards/board_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SymbolVisiblityWrapper extends ConsumerWidget {
  const SymbolVisiblityWrapper(
      {super.key, required this.hidden, required this.child});

  final bool hidden;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!hidden) return child;

    final isParentMode = ref.watch(isParentModeProvider);

    if (isParentMode) {
      return Opacity(opacity: 0.2, child: child);
    }

    return SizedBox();
  }
}
