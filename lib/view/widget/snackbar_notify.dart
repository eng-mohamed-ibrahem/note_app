import 'package:flutter/material.dart';

class NotifySnackBar extends StatelessWidget {
  final Widget content;
  const NotifySnackBar({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: content,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      width: 50,
    );
  }
}
