import 'package:flutter/material.dart';
import 'package:penger/resources/app_colours.dart';
import 'package:penger/resources/app_spacing.dart';
import 'package:penger/resources/app_strings.dart';
import 'package:penger/resources/app_styles.dart';

class CheckboxInputComponent extends StatefulWidget {
  final bool value;
  final bool isEnabled;
  final Widget? label;
  final ValueChanged<bool> onChanged;

  const CheckboxInputComponent({super.key, required this.value, required this.onChanged, this.label, this.isEnabled = true});

  @override
  State<CheckboxInputComponent> createState() => _CheckboxInputComponentState();
}

class _CheckboxInputComponentState extends State<CheckboxInputComponent> {
  late bool value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.5,
          child: Checkbox(
              activeColor: AppColours.primaryColour,
              checkColor: Colors.white,
              side: BorderSide(color: AppColours.primaryColour),
              value: value,
              onChanged: widget.isEnabled ? (bool? newValue) {
                setState(() => value = newValue!);
                widget.onChanged(value);
              } : null),
        ),
        if(widget.label != null)...[
          AppSpacing.horizontal(size: 4),
          Expanded(child: widget.label!)
        ]
      ],
    );
  }

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }
}
