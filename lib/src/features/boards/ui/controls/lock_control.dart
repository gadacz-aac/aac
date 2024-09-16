import 'dart:async';

import 'package:aac/src/features/settings/utils/protective_mode.dart';
import 'package:flutter/material.dart';

class LockControl extends StatefulWidget {
  const LockControl({super.key, this.isOpen = false});

  final bool isOpen;

  @override
  State<LockControl> createState() => _LockControlState();
}

class _LockControlState extends State<LockControl> {
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
            stopProtectiveMode();
            Navigator.popUntil(
                context, (Route<dynamic> predicate) => predicate.isFirst);

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
