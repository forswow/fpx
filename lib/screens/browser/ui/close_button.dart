import 'package:flutter/material.dart';

class CloseBtn extends StatelessWidget {
  const CloseBtn({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(129, 0, 0, 0),
        ),
        child: const Icon(
          Icons.close_rounded,
          size: 14,
          color: Color(0xFFC2C1C1),
        ),
      ),
    );
  }
}
