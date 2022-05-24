import 'package:flutter/material.dart';

class CustomListTitle extends StatelessWidget {
  CustomListTitle({
    Key? key,
    required this.icon,
    required this.title,
    required this.route,
    this.fontSize,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String route;
  double? fontSize;

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
          style: fontSize == null
              ? Theme.of(context).textTheme.headline4
              : Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontSize: fontSize),
        ),
        onTap: () {
          Navigator.of(context).pushReplacementNamed(route);
        },
      ),
    );
  }
}
