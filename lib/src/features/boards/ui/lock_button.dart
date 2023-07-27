import 'dart:async';

import 'package:flutter/material.dart';

import '../../settings/utils/protective_mode.dart';

class LockButton extends StatefulWidget {
  const LockButton({
    super.key,
  });

  @override
  State<LockButton> createState() => _LockButtonState();
}

class _LockButtonState extends State<LockButton> {
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
        icon: const Icon(Icons.lock));
  }
}
