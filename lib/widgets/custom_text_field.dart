import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final bool obscureText;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final void Function(String)? onChange;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  const CustomTextField({super.key, required this.label, required this.keyboardType, required this.obscureText, required this.prefixIcon, this.suffixIcon, this.controller, this.onChange, this.onTap, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChange,
      onTap: onTap,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: label,
        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red.shade400,width: 2), borderRadius: BorderRadius.circular(16)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade500), borderRadius: BorderRadius.circular(12)),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red.shade400,width: 1.5), borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.deepPurple,width: 2), borderRadius: BorderRadius.circular(16))
      ),
    );
  }
}