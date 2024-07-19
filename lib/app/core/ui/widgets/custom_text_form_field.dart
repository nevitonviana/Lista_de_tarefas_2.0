import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final String label;
  final IconData? icon;
  final Widget? suffixIcon;
  final double horizontalSize;
  final TextInputType textInputType;

  const CustomTextFormField(
      {super.key,
      required this.controller,
      this.focusNode,
      this.initialValue,
      required this.label,
      this.icon,
      this.horizontalSize = 0,
      this.textInputType = TextInputType.text,
      this.validator, this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: horizontalSize, vertical: 10),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        initialValue: initialValue,
        validator: validator,
        keyboardType: textInputType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          prefixIcon: Icon(icon),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
