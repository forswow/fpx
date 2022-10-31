import 'package:flutter/material.dart';

import '../../../utils/const.dart';

class SettingsCardItem extends StatelessWidget {
  const SettingsCardItem({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          title: Text(
            title,
            style: kS14W600,
          ),
        ),
      ),
    );
  }
}