import 'package:flutter/material.dart';

class AlertDialogCustomized extends StatelessWidget {
  const AlertDialogCustomized({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      title: Text('Error'),
      content: Text(errorMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Ok'),
        ),
      ],
    );
  }
}
