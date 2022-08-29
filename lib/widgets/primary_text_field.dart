import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? inputType;
  final bool obscureText;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final String? hintText;
  final bool isPasswordField;
  final bool isReadOnly;
  final int? length;
  final Color backgroundColor;
  final double radius;
  final List<BoxShadow>? boxShadows;
  final Widget? leading;
  final Widget? trailing;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;

  const PrimaryTextField(
      {Key? key,
      this.controller,
      this.inputType,
      this.obscureText = false,
      this.onChanged,
      this.validator,
      this.hintText,
      this.isPasswordField = false,
      this.isReadOnly = false,
      this.length,
      this.radius = 16.0,
      this.boxShadows,
      this.leading,
      this.trailing,
      this.inputFormatters,
      this.maxLines = 1,
      this.backgroundColor = Colors.white})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: backgroundColor,
          boxShadow: boxShadows ?? []),
      child: TextFormField(
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
        controller: controller,
        keyboardType: inputType,
        obscureText: obscureText,
        maxLines: maxLines,
        maxLength: length,
        onChanged: onChanged,
        readOnly: isReadOnly,
        validator: validator,
        inputFormatters: inputFormatters,
        decoration: buildInputDecoration(hintText),
      ),
    );
  }

  InputDecoration buildInputDecoration(String? hinttext) {
    return InputDecoration(
        isDense: true,
        counterText: "",
        contentPadding: EdgeInsets.only(
            bottom: 8.0,
            top: 8.0,
            left: (leading != null) ? 0 : 10,
            right: (trailing != null) ? 0 : 10),
        hintText: hinttext,
        prefixIcon: leading,
        prefixIconConstraints: (leading != null)
            ? const BoxConstraints(minWidth: 48.0, minHeight: 24.0)
            : const BoxConstraints(),
        suffixIcon: trailing,
        suffixIconConstraints: (trailing != null)
            ? const BoxConstraints(minWidth: 48.0, minHeight: 24.0)
            : const BoxConstraints(),
        hintStyle: const TextStyle(
            color: Colors.grey, fontSize: 16, fontWeight: FontWeight.normal),
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none);
  }
}
