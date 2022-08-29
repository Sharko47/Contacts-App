import 'package:flutter/material.dart';

import '../constant/app_color.dart';
import 'my_text.dart';

class CustomContainer extends StatelessWidget {
  final double radius;
  final String text;
  final VoidCallback? onClick;
  final Color color;
  final Widget? trailing;
  final double? width;
  final double? height;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double verticalPadding;
  final double horizontalPadding;
  final Widget? child;
  final TextAlign textAlign;
  final List<BoxShadow>? boxShadows;
  final EdgeInsetsGeometry? margin;
  final Color? gradientColorOne;
  final Color? gradientColorTwo;
  const CustomContainer(
      {Key? key,
      this.radius = 8.0,
      this.text = "",
      this.color = white,
      this.gradientColorOne,
      this.gradientColorTwo,
      this.trailing,
      this.textColor = Colors.grey,
      this.fontSize = 16.0,
      this.fontWeight = FontWeight.normal,
      this.height,
      this.verticalPadding = 12.0,
      this.horizontalPadding = 12.0,
      this.textAlign = TextAlign.start,
      this.width,
      this.onClick,
      this.boxShadows,
      this.margin,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          gradient: LinearGradient(
            colors: (gradientColorOne == null)
                ? [color, color]
                : [gradientColorOne!, gradientColorTwo!],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: boxShadows ?? []),
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onClick,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: child ??
              Row(
                children: [
                  Expanded(
                    child: MyText(
                      text: text,
                      color: textColor,
                      fontWeight: fontWeight,
                      fontSize: fontSize,
                      textAlignment: textAlign,
                    ),
                  ),
                  trailing ?? const SizedBox()
                ],
              ),
        ),
      ),
    );
  }
}
