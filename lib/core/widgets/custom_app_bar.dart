import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart';

AppBar buildAppBar(context,
    {String? title,
    void Function()? onTap,
    bool visibleLeading = true,
    List<Widget>? actions}) {
  return AppBar(
    actions: actions,
    leading: visibleLeading
        ? GestureDetector(onTap: onTap, child: const Icon(Icons.arrow_back_ios))
        : const SizedBox.shrink(),
    centerTitle: true,
    title: Text(
      title ?? "",
      style: TextStyles.bold19,
    ),
  );
}
