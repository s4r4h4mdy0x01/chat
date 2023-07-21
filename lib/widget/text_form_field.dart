import 'package:flutter/material.dart';

class MyTextFormfield extends StatelessWidget {
  MyTextFormfield(
      {super.key, this.hintText, this.textInputType, this.onChanged,this.validator,this.obscureText=false,});
  String? hintText;
  TextInputType? textInputType;
  Function(String)? onChanged;
 String? Function(String?)?  validator;
 bool obscureText;
  @override

  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
        validator: validator,
        onChanged: onChanged,
        keyboardType: textInputType,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white60),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
        ));
  }
}
