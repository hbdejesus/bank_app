import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.controller,
    required this.label,
    this.prefixIcon,
    this.isRequired = false,
    this.obscureText = false,
    this.textInputType,
    this.validator,
    this.helperText,
    this.inputFormatters,
    this.autovalidateMode,
    super.key,
  });

  final FormFieldValidator<String>? validator;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final String label;
  final String? helperText;
  final bool isRequired;
  final bool obscureText;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (prefixIcon != null) ...[
          prefixIcon!,
          const Gap(20),
        ],
        Expanded(
          child: TextFormField(
            autovalidateMode: autovalidateMode,
            validator: validator ?? (text) => (text?.isEmpty ?? true) ? 'Required' : null,
            controller: controller,
            decoration: InputDecoration(
              label: Text(label),
              helperText: helperText,
            ),
            keyboardType: textInputType,
            obscureText: obscureText,
            inputFormatters: inputFormatters,
          ),
        ),
      ],
    );
  }
}
