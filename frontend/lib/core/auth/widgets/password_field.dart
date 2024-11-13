import 'package:flutter/material.dart';

import '../../../utils/validity_methods.dart';

// import 'package:reconnect/core/auth/widgets/text_action_button.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
    this.controller,
    this.obscureText = true,
    this.labelText,
    this.hintText,
    this.textInputAction = TextInputAction.done,
    this.validator = validatePassword,
  }) : super(key: key);
  final TextEditingController? controller;
  final bool obscureText;
  final String? labelText;
  final String? hintText;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool hideText = false;
  @override
  void initState() {
    hideText = widget.obscureText;
    super.initState();
  }

  // AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: hideText,
      validator: widget.validator,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixIcon: Icon(
          Icons.lock,
          color: Theme.of(context).colorScheme.primary,
          size: 18,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              hideText = !hideText;
            });
          },
          icon: Icon(
            hideText ? Icons.visibility_rounded : Icons.visibility_off,
            color: Theme.of(context).colorScheme.primary,
            size: 18,
          ),
        ),
      ),
    );
  }
}
