import 'package:flutter/material.dart';

class SuggestionTextField extends StatefulWidget {
  const SuggestionTextField({
    super.key,
    required this.controller,
    this.values = const [],
    this.validator,
    this.labelText,
    this.keyboardType,
    this.focusNode,
  });
  final TextEditingController controller;
  final List<String> values;
  final String? Function(String?)? validator;
  final String? labelText;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;

  @override
  State<SuggestionTextField> createState() => _SuggestionTextFieldState();
}

class _SuggestionTextFieldState extends State<SuggestionTextField> {
  bool hasFocus = false;
  @override
  void initState() {
    super.initState();
    widget.focusNode?.addListener(() {
      if (hasFocus != (widget.focusNode?.hasFocus ?? false)) {
        setState(() {
          hasFocus = widget.focusNode?.hasFocus ?? false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            labelText: widget.labelText,
          ),
        ),
        // AutocompleteTextField(),
        if (widget.focusNode?.hasFocus ?? false)
          Container(
            color: Colors.amber,
            constraints: const BoxConstraints(
              maxHeight: 250,
              minHeight: 10,
            ),
            height: 150,
            child: ListView.builder(
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  widget.values[index],
                ),
                onTap: () {
                  if (widget.values[index] != widget.controller.text) {
                    widget.controller.text = widget.values[index];
                  }
                },
              ),
              shrinkWrap: true,
              itemCount: widget.values.length,
            ),
          ),
      ],
    );
  }
}
