import 'package:flutter/material.dart';

import '../const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const CustomTextFormField(
      {required this.onChanged,
      this.hintText,
      this.errorText,
      this.obscureText = false,
      this.autofocus = false,
      this.controller,
      super.key});

  @override
  Widget build(BuildContext context) {
    const baseBorder = OutlineInputBorder(
        borderSide: BorderSide(color: INPUT_BORDER_COLOR, width: 1));

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      autofocus: autofocus,
      onChanged: onChanged,
      cursorColor: PRIMARY_COLOR,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          hintText: hintText,
          errorText: errorText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          fillColor: INPUT_BG_COLOR,
          filled: true,
          // border: baseBorder,
          enabledBorder: baseBorder,
          focusedBorder: baseBorder.copyWith(
              borderSide:
                  baseBorder.borderSide.copyWith(color: PRIMARY_COLOR))),
    );
  }
}
