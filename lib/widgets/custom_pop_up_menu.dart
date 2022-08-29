import 'package:contactsassignment/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'my_text.dart';

class CustomPopUpMenu extends StatelessWidget {
  final List<String> popMenuItems;
  final Icon icon;
  final double horizontalPadding;
  final Function(int) onMenuCliked;

  const CustomPopUpMenu(
      {Key? key,
      required this.popMenuItems,
      required this.onMenuCliked,
      this.icon = const Icon(Icons.more_vert),
      this.horizontalPadding = 8.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 24.0,
          maxWidth: 24.0,
        ),
        child: PopupMenuButton(
            elevation: 3,
            color: Colors.black54,
            icon: icon,
            padding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            )),
            itemBuilder: (context) => List.generate(
                popMenuItems.length,
                (index) => PopupMenuItem(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    onTap: onMenuCliked(index),
                    child: MyText(
                      text: popMenuItems[index],
                      color: white,
                      fontSize: 12.0,
                    )))),
      ),
    );
  }
}
