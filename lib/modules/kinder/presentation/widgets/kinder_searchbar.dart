import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/constants/app_constants.dart';
import 'package:kiosk/modules/kinder/logic/kinder_cubit.dart';

class KinderSearchbar extends StatelessWidget {
  KinderSearchbar({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(marginStandard),
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: 'Namen eingeben',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.secondary),
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              _controller.clear();
              context.read<KinderCubit>().searchKind(_controller.text, context);
            },
          ),
        ),
        onChanged: (input) {
          context.read<KinderCubit>().searchKind(input, context);
        },
      ),
    );
  }
}
