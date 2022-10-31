import 'package:flutter/material.dart';

import '../../../utils/const.dart';
import 'close_button.dart';
import 'mini.dart';

class Miniature extends StatelessWidget {
  const Miniature({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    required this.onDel,
  }) : super(key: key);

  final int currentIndex;
  final void Function(int) onTap, onDel;
  final List<Mini> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final item in items)
          Padding(
            padding: kP2,
            child: Stack(
              children: [
                InkWell(
                  onTap: () => onTap.call(items.indexOf(item)),
                  child: item,
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child:
                        CloseBtn(onTap: () => onDel.call(items.indexOf(item))))
              ],
            ),
          ),
      ],
    );
  }
}