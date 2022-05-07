import 'package:flutter/material.dart';

class CustomListTitle extends StatelessWidget {
  const CustomListTitle({
    Key? key,
    required this.icon,
    required this.title,
    required this.route,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String route;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: 300,
      height: 80,
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline4,
        ),
        onTap: () {
          Navigator.of(context).pushReplacementNamed(route);
        },
      ),
    );
  }
}
