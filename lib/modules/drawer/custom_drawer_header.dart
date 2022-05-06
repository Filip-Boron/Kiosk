import 'package:flutter/material.dart';
import 'package:kiosk/constants/app_constants.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: 60,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shop_rounded,
            size: iconSizeStandard,
          ),
          const SizedBox(
            width: marginStandard,
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Kiosk App',
              maxLines: 1,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ],
      ),
    );
  }
}
