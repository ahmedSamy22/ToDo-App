import 'package:flutter/material.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType keyboardTybe,
  bool isPassword = false,
  required IconData prefixIcon,
  required String label,
  String? Function(dynamic value)? validator,
  Function()? onTap,
  Function()? suffixPressed,
  IconData? suffix,
  int? maxLines,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardTybe,
    obscureText: isPassword,
    validator: validator,
    onTap: onTap,
    maxLines: maxLines,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon),
      labelText: label,
      border: OutlineInputBorder(),
      suffixIcon: suffix != null
          ? IconButton(
              icon: Icon(suffix),
              onPressed: suffixPressed,
            )
          : null,
    ),
  );
}

Widget defaultButton({
  required Function() function,
  Color background = Colors.cyan,
  required double width,
  required String text,
}) {
  return (Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: background,
    ),
    width: width,
    child: MaterialButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 20.0,
          //   color: Colors.white,
        ),
      ),
    ),
  ));
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
