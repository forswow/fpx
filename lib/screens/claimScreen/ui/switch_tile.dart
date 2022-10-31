import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/const.dart';

class SwitchTile extends StatelessWidget {
  const SwitchTile({
    Key? key,
    required this.title,
    required this.boolean,
  }) : super(key: key);

  final String title;
  final RxBool boolean;
  @override
  Widget build(BuildContext context) {
    return Obx(() => SwitchListTile(
        title: Text(
          title,
          style: kS14W600,
        ),
        value: boolean.value,
        onChanged: (val) {
          boolean.toggle();
        }));
  }
}