import 'package:flutter/material.dart';
class InputTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;



  const InputTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    });



  @override
  Widget build(BuildContext context) {
    return  Padding(
              padding:  EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: controller,
                obscureText: obscureText,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:BorderSide(
                      color: const Color.fromARGB(255, 211, 211, 211)
                      ) 
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                        color: const Color.fromARGB(255, 111, 111, 111))
                      ),
                      fillColor: const Color.fromARGB(255, 250, 250, 250),
                      filled: true,
                      hintText: hintText,
                ),
              ),
            );
  }
}