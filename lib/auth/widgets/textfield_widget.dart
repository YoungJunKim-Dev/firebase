import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const TextfieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(
            12,
          )),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
        ),
        child: TextField(
          obscureText:
              (hintText == "password" || hintText == "confirm password")
                  ? true
                  : false,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
