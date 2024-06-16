import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const MyTextBox({super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return TextField(
      style: const TextStyle(color: Colors.black, fontSize: 20),
      controller: controller,
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 4,
      cursorColor: theme.primaryColor,
      cursorHeight: 20,
      cursorWidth: 2,
      cursorRadius: const Radius.circular(20),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        hintText: label,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: theme.primaryColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: theme.primaryColor)),
        border: OutlineInputBorder(),
        label: Text(
          label,
          style: TextStyle(color: theme.primaryColor, fontSize: 20),
        ),
        suffixIcon: const Icon(Icons.add_task),
      ),
    );
  }
}
