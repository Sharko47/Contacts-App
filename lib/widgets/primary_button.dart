import 'package:flutter/material.dart';

import '../constant/app_color.dart';
import 'my_text.dart';

class PrimaryButton extends StatelessWidget {
  final String? btnText;
  final double width;
  final double height;
  final Function()? onPressed;
  final bool disablePadding;
  final Color? color;
  final Color gradientColorOne;
  final Color gradientColorTwo;
  final bool hasBorder;
  final Color textColor;
  final double textSize;
  final double cornerRadius;
  final Widget? child;
  final double elevation;

  const PrimaryButton(
      {Key? key,
      this.btnText,
      this.width = 90,
      this.height = 45.0,
      this.onPressed,
      this.disablePadding = false,
      this.color,
      this.hasBorder = false,
      this.gradientColorOne = primaryButtonGradientLeft,
      this.gradientColorTwo = primaryButtonGradientRight,
      this.textColor = Colors.white,
      this.textSize = 18.0,
      this.child,
      this.elevation = 1,
      this.cornerRadius = 8.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: disablePadding
          ? EdgeInsets.zero
          : const EdgeInsets.only(right: 16.0, left: 16.0),
      child: Tooltip(
        message: btnText ?? "",
        child: SizedBox(
          height: height,
          width: width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0.0),
              onPrimary: Colors.black,
              elevation: elevation,
              shadowColor: color ?? gradientColorTwo,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(cornerRadius)),
            ),
            onPressed: onPressed,
            child: Ink(
              decoration: BoxDecoration(
                border: hasBorder ? Border.all() : const Border(),
                borderRadius: BorderRadius.circular(cornerRadius),
                gradient: LinearGradient(
                  colors: (color != null)
                      ? [color!, color!]
                      : [gradientColorOne, gradientColorTwo],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Container(
                  width: width,
                  height: height,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(cornerRadius)),
                  child: child ??
                      MyText(
                        text: btnText ?? "",
                        textAlignment: TextAlign.center,
                        color: textColor,
                        fontSize: textSize,
                      )),
            ),
          ),
        ),
      ),
    );
  }
}
