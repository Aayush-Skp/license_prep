import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validator;
  final bool showfocus;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    this.label,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.validator,
    this.showfocus = true,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: isPassword,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: showfocus
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
            filled: true,
            fillColor: const Color(0xFF3C3D37),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 17),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
