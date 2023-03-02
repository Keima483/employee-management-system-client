import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    Key? key,
    required this.controller,
    required this.lable,
    this.isPassword = false,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String lable;
  final bool isPassword;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.black,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        label: Text(
          lable,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
