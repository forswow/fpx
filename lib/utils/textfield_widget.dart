import '../screens/browser/ui/close_button.dart';

import 'package:flutter/material.dart';

import 'const.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.hintText,
    required this.onTap,
    required this.onSubmitted,
    required this.controller,
  }) : super(key: key);
  final String hintText;
  final Function() onTap;
  final Function(String) onSubmitted;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 36,
        child: Material(
          borderRadius: kBR8,
          elevation: 2,
          child: Padding(
            padding: kP4,
            child: TextField(
              controller: controller,
              scrollPadding: kP10,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintText: hintText,
                counterStyle: kS14W600,
                labelStyle: kS14W600,
                floatingLabelStyle: kS14W600,
                hintStyle: kS14W600,
                hintMaxLines: 1,
                border: InputBorder.none,
                isDense: true,
                constraints: const BoxConstraints(minWidth: 2, minHeight: 2),
                suffixIconConstraints:
                    const BoxConstraints(minWidth: 2, minHeight: 2),
                suffixIcon: CloseBtn(onTap: onTap),
              ),
              onSubmitted: onSubmitted,
            ),
          ),
        ));
  }
}