import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? obscureText;
  final bool? autofocus;
  final String? Function(String?)? validator;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? helperText;
  final String? hintText;
  final int? maxLength;
  final int? maxLines;
  final AutovalidateMode? autovalidateMode;
  final void Function(String)? onChanged; // anonymous function
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final bool? readOnly;
  final Widget? label;
  final FloatingLabelBehavior? floatingLabelBehavior;

  const InputTextFormField(
      {super.key,
      this.floatingLabelBehavior,
      this.label,
      this.readOnly,
      this.hintText,
      this.enabled,
      this.controller,
      this.obscureText,
      this.autofocus,
      this.validator,
      this.labelText,
      this.prefixIcon,
      this.suffixIcon,
      this.keyboardType,
      this.helperText,
      this.maxLength,
      this.maxLines,
      this.onChanged,
      this.autovalidateMode,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
      enabled: enabled ?? true,
      inputFormatters: inputFormatters,
      style: const TextStyle(fontSize: 20),
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      maxLength: maxLength,
      maxLines: maxLines ?? 1,
      controller: controller,
      validator: validator,
      autofocus: autofocus ?? false,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        labelText: labelText,
        floatingLabelBehavior: floatingLabelBehavior,
        label: label,
        helperText: helperText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
