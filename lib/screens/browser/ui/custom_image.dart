import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final double? width;
  final double? height;
  final double maxWidth;
  final double maxHeight;
  final double minWidth;
  final double minHeight;
  final Uri? url;

  const CustomImage(
      {Key? key,
      this.url,
      this.width,
      this.height,
      this.maxWidth = double.infinity,
      this.maxHeight = double.infinity,
      this.minWidth = 0.0,
      this.minHeight = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(shape: BoxShape.circle),
      constraints: BoxConstraints(
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          minHeight: minHeight,
          minWidth: minWidth),
      clipBehavior: Clip.hardEdge,
      width: width,
      height: height,
      child: getImage(),
    );
  }

  Widget? getImage() {
    if (url != null) {
      if (url!.scheme == "data") {
        Uint8List bytes = const Base64Decoder()
            .convert(url.toString().replaceFirst("data:image/png;base64,", ""));
        return Image.memory(
          bytes,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => getBrokenImageIcon(),
        );
      }
      return Image.network(
        url.toString(),
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => getBrokenImageIcon(),
      );
    }
    return getBrokenImageIcon();
  }

  Widget getBrokenImageIcon() {
    return Image.asset(
      'assets/browser.jpg',
      fit: BoxFit.contain,
    );
  }
}