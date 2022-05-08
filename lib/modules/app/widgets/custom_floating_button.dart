import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    Key? key,
    required this.icon,
    required this.pressAction,
  }) : super(key: key);

  final Function(BuildContext) pressAction;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      child: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () => pressAction(context),
        child: Icon(
          icon,
          color: Colors.black,
          size: 50,
        ),
      ),
    );
  }
}
