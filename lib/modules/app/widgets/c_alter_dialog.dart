import 'package:flutter/material.dart';

class CAltertDialog extends StatelessWidget {
  const CAltertDialog(
      {Key? key,
      required this.context,
      required this.titel,
      required this.content})
      : super(key: key);

  final String titel;
  final String content;
  final BuildContext context;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titel),
      content: Text(content),
      actions: [
        TextButton(
          child: Text(
            'Abbrechen',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).colorScheme.secondary,
            ),
          ),
          onPressed: () => Navigator.pop(context, true),
          child: const Text('BESTÄTIGEN'),
        )
      ],
    );
  }
}
