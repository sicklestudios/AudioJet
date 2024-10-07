import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  String title;
  String action;
  SectionHeader({
    required this.title,
    required this.action,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
        Text(action,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }
}
