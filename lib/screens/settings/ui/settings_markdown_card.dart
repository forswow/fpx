import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';

import '../../../utils/const.dart';

class SettingsMarkdownCard extends StatelessWidget {
  const SettingsMarkdownCard({
    Key? key,
    required this.title,
    required this.markdown,
  }) : super(key: key);

  final Future<String> markdown;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () async => Get.defaultDialog(
          title: title,
          confirm: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('OK')),
          content: Expanded(
            child: Markdown(
              data: await markdown,
              shrinkWrap: true,
            ),
          ),
        ),
        child: ListTile(
          title: Text(
            title,
            style: kS14W500,
          ),
        ),
      ),
    );
  }
}
