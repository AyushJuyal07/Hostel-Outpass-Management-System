import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({
    super.key,
    required this.trueTitle,
    required this.falseTitle,
    required this.onChanged,
    this.initialValue = true,
  });
  final String trueTitle;
  final String falseTitle;
  final bool initialValue;
  final Function(bool) onChanged;

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool value = true;
  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: BorderSide(
              color: (value) ? Colors.green : Colors.black54,
            ),
          ),
          onPressed: () {
            if (value == true) return;
            setState(() {
              value = true;
              widget.onChanged(true);
            });
          },
          child: Text(widget.trueTitle),
        ),
      ],
    );
  }
}
