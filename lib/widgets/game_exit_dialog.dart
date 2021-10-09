import 'package:flutter/material.dart';

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
                    title: const Text('Sair da sala?'),
                    actions: [
                      ElevatedButton(
                          onPressed: onElevatedPressed,
                          child: const Text('Continuar na sala')),
                      TextButton(
                          onPressed: onPlainPressed,
                          child: const Text('Voltar para tela inicial')),
                    ],
                  ));
          return false;
        },
        child: child);
  }
}
