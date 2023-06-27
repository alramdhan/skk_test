import 'package:flutter/material.dart';

import 'package:skk_test/src/constants.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({
    Key? key,
    required this.label,
    required this.controller,
    this.showPassword = true,
    this.enableSuggestion = true,
    this.autoCorrect = true,
    this.suffixIcon
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final bool? showPassword;
  final bool? enableSuggestion;
  final bool? autoCorrect;
  final Widget? suffixIcon;

  @override
  State<StatefulWidget> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label,
            style: const TextStyle(
              color: neonBlue,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 1
            ),
          ),
          TextFormField(
            obscureText: !widget.showPassword! ? true : false,
            enableSuggestions: widget.enableSuggestion!,
            autocorrect: widget.autoCorrect!,
            controller: widget.controller,
            validator: (value) {
              if(value == null || value.isEmpty) {
                return 'this field is required!';
              }

              return null;
            },
            style: const TextStyle(
              color: lightDarkBlue,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 1
            ),
            cursorColor: neonBlue,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              filled: true,
              fillColor: neonBlue,
              enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
              suffixIcon: widget.suffixIcon
            )
          )
        ],
      ),
    );
  }
}