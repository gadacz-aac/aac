import 'dart:async';

import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/settings/utils/protective_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LockButton extends ConsumerStatefulWidget {
  const LockButton({super.key, this.isOpen = false});

  final bool isOpen;

  @override
  ConsumerState<LockButton> createState() => _LockButtonState();
}

class _LockButtonState extends ConsumerState<LockButton> {
  int _tapLeft = 3;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          if (_tapLeft == 3) {
            Timer(const Duration(seconds: 3), () {
              _tapLeft = 3;
            });
          }
          _tapLeft -= 1;

          if (_tapLeft == 0) {
            ref.read(isParentModeProvider.notifier).state = true;
            stopProtectiveMode();

            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          } else {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Tap $_tapLeft times to leave protective mode")));
          }
        },
        icon: Icon(widget.isOpen ? Icons.lock_open : Icons.lock_outline));
  }
}
