import 'package:flutter/material.dart';

import '../extensions/size_screen_extension.dart';
import '../extensions/theme_extension.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final double? widget ;

  const CustomButton({super.key, required this.label, required this.onPressed, this.icon, this.widget = 70});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        backgroundColor: context.primaryColorLight,
        padding: EdgeInsets.symmetric(horizontal: widget!.w),
        elevation: 2,
        side: const BorderSide(
          color: Colors.transparent,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        foregroundColor: Colors.black,
      ),
      onPressed: onPressed,
      label: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          label,
          style: TextStyle(fontSize: 20.tx, fontWeight: FontWeight.bold),
        ),
      ),
      icon: Icon(
        icon,
        color: Colors.black,
      ),
    );
  }
}
