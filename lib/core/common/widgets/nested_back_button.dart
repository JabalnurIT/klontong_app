import 'package:flutter/material.dart';
import '../../extensions/context_extensions.dart';

class NestedBackButton extends StatelessWidget {
  const NestedBackButton({super.key, this.onPressed});

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, result) {
        try {
          onPressed?.call();
          context.pop();
        } catch (_) {
          Navigator.of(context).pop();
        }
      },
      child: IconButton(
        color: Colors.white,
        iconSize: 30,
        icon: Icon(
          Theme.of(context).platform == TargetPlatform.iOS
              ? Icons.arrow_back_ios_new
              : Icons.arrow_back,
        ),
        onPressed: () {
          try {
            onPressed?.call();
            context.pop();
          } catch (_) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
