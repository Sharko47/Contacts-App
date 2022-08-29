import 'package:flutter/material.dart';

import '../constant/app_color.dart';
import 'my_text.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final Color appBarColorValue;
  final String title;
  final Color titleColor;
  final FontWeight titleFontWeight;
  final double titleFontSize;
  final List<Widget>? actionsList;
  final VoidCallback? onBackPressed;
  final Widget? leading;
  const CustomAppBar(
      {Key? key,
      this.appBarColorValue = appBarColor,
      this.leading,
      required this.title,
      this.titleColor = white,
      this.titleFontSize = 22.0,
      this.titleFontWeight = FontWeight.w500,
      this.actionsList,
      this.onBackPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        titleSpacing: 0,
        leading: leading ??
            Tooltip(
                message: "Back",
                child: InkWell(
                    onTap: onBackPressed, child: const Icon(Icons.arrow_back))),
        backgroundColor: appBarColor,
        title: MyText(
          text: title,
          fontSize: titleFontSize,
          fontWeight: titleFontWeight,
          color: titleColor,
        ),
        actions: actionsList,
        elevation: 1);
  }

  @override
  Size get preferredSize => const Size.fromHeight(55.0);
}
