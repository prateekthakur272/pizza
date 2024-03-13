import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final bool? obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final void Function(String)? onChange;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final bool? readOnly;
  const CustomFormField({super.key, this.label, this.keyboardType, this.obscureText, this.prefixIcon, this.suffixIcon, this.controller, this.onChange, this.onTap, this.validator, this.readOnly});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText??false,
      onChanged: onChange,
      onTap: onTap,
      readOnly: readOnly??false,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide.none),
        fillColor: Colors.white,
        filled: true
        // focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red.shade400,width: 2), borderRadius: BorderRadius.circular(50)),
        // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade500), borderRadius: BorderRadius.circular(50)),
        // errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red.shade400,width: 1.5), borderRadius: BorderRadius.circular(50)),
        // focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.deepPurple,width: 2), borderRadius: BorderRadius.circular(25))
      ),
    );
  }
}