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
        onWillPop: () => ExitGameAlert(context, onElevatedPressed, onPlainPressed),
        child: child);
  }
}

Future<bool> ExitGameAlert (context, stayPressed, leavePressed) async {
  await showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            title: Text('exitQuestion'.tr),
            actions: [
              TextButton(
                  onPressed: leavePressed,
                  child: Text('returnToStart'.tr)),
              ElevatedButton(
                  onPressed: stayPressed,
                  child: Text('stayInTheRoom'.tr)),
            ],
          ));
  return false;
}