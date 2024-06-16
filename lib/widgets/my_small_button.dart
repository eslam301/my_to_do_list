import 'package:flutter/material.dart';

class MySmallButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  const MySmallButton(
      {super.key, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return MaterialButton(
        clipBehavior: Clip.antiAlias,
        color: theme.primaryColor,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ));
  }
}
