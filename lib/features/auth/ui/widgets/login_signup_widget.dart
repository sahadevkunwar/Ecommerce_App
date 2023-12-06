import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.labelText,
      required this.validator,
      this.maxLines,
      });

  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final String? Function(String? value) validator;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(labelText),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            maxLines: maxLines,
            textInputAction: TextInputAction.next,
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hintText,
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
