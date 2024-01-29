import 'package:example/ui/style/colors.dart';
import 'package:example/ui/style/test_style.dart';
import 'package:flutter/material.dart';

class PTTextField extends StatelessWidget {
  const PTTextField({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText,
    this.errorText,
    this.validator,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String label;
  final String? errorText;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    final errorText = this.errorText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 68,
          child: _TextField(
            controller: controller,
            label: label,
            validator: validator,
            obscureText: obscureText,
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 10),
          Text(
            errorText,
            style: PTTextStyles.label.copyWith(color: PTColors.error),
          ),
        ],
      ],
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    required this.controller,
    required this.label,
    this.obscureText,
    this.validator,
  });

  final String label;
  final TextEditingController controller;
  final bool? obscureText;
  final String? Function(String?)? validator;
  static const _borderColor = Color(0xFF777777);
  static const _fillColor = Color(0xFF2F2F2F);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      style: PTTextStyles.bodyMedium.copyWith(color: PTColors.textWhite),
      cursorColor: PTColors.textWhite,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: PTTextStyles.bodyMedium.copyWith(color: PTColors.textWhite),
        fillColor: _fillColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
        filled: true,
        focusedBorder: _getBorder(PTColors.lcYellow),
        border: _getBorder(_borderColor),
        enabledBorder: _getBorder(_borderColor),
        errorBorder: _getBorder(PTColors.error), // Customize for error state
        focusedErrorBorder: _getBorder(PTColors.error), // Customize for focused error state
      ),
    );
  }

  OutlineInputBorder _getBorder(Color color) => OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: color),
      );
}
