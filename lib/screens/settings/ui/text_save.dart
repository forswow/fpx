import 'package:flutter/material.dart';

import '../../../utils/const.dart';

class TextSave extends StatelessWidget {
  const TextSave({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.onTap,
    required this.onSubmitted,
    required this.value,
    this.keyboardType,
    this.maxLength,
    required this.errorText,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String hintText, value;
  final Function() onTap;
  final Function(String) onSubmitted;
  final int? maxLength;
  final String? errorText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kP8,
      child: Row(
        children: [
          Expanded(
            child: Material(
              borderRadius: kBR12,
              elevation: 3,
              child: Padding(
                padding: kPH4,
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  maxLength: maxLength,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hintText,
                      errorText: errorText,
                      suffixIcon: GestureDetector(
                        onTap: onTap,
                        child: value != ''
                            ? const Icon(
                                Icons.done,
                                color: Colors.green,
                                size: 24,
                              )
                            : const Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 24,
                              ),
                      )),
                  onSubmitted: onSubmitted,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
