import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/utils/validation.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.obscureText = false,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.validators,
    this.prefixIcon,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final bool obscureText;
  final String labelText;
  final String hintText;
  final IconData? prefixIcon;
  final List<Validation>? validators;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  var _isObscure = false;

  @override
  void initState() {
    _isObscure = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                icon: Icon(
                  _isObscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              )
            : null,
      ),
      obscureText: _isObscure,
      validator: widget.validators?.validate,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: widget.inputFormatters,
    );
  }
}
