import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {

  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  const MyTextfield({super.key,required this.hintText,required this.controller,required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding( padding: const EdgeInsets.symmetric(horizontal: 25),
    child: TextField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        
        focusedBorder: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
        ),
        fillColor: Theme.of(context).colorScheme.secondary,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
    ),
    );
  }
}