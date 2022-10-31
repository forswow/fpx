import 'package:flutter/material.dart';

import '../../../utils/const.dart';

class InfoBar extends StatelessWidget {
  const InfoBar({
    Key? key,
    required this.widgetL,
    required this.widgetR,
  }) : super(key: key);

  final Widget widgetL, widgetR;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [widgetL, kSB4, widgetR],
    );
  }
}