import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameExitDialog extends StatelessWidget {

  const GameExitDialog({
    Key? key,
    this.forceNoPop = false,
    required this.onElevatedPressed,
    required this.onPlainPressed,
    required this.child,
  }) : super(key: key);

  final bool forceNoPop;
  final VoidCallback onElevatedPressed;
  final VoidCallback onPlainPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          await showDialog(
              context: context,
              builder: (_) =>
                  AlertDialog(
                    title: Text('exitQuestion'.tr),
                    actions: [
                      ElevatedButton(
                          onPressed: onElevatedPressed,
                          child: Text('stayInTheRoom'.tr)),
                      TextButton(
                          onPressed: onPlainPressed,
                          child: Text('returnToStart'.tr)),
                    ],
                  ));
          return false;
        },
        child: child);
  }
}
