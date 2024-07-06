import 'package:flutter/material.dart';
import 'package:penger/resources/app_colours.dart';
import 'package:penger/resources/app_styles.dart';

class ButtonComponent extends StatefulWidget {
  final String label;
  final double? width;
  final Widget? icon;
  final ButtonType type;
  final Function() onPressed;
  final bool isLoading;

  const ButtonComponent({super.key, required this.label, this.icon, this.type = ButtonType.primary, this.width, required this.onPressed, this.isLoading = false});

  @override
  State<ButtonComponent> createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {
  final Map<ButtonType, Color> backgroundColour = {
    ButtonType.primary: AppColours.primaryColour,
    ButtonType.secondary: AppColours.primaryColourLight,
    ButtonType.light: Colors.white,
  };

  final Map<ButtonType, Color> foregroundColour = {
    ButtonType.primary: Colors.white,
    ButtonType.secondary: AppColours.primaryColour,
    ButtonType.light: Colors.black,
  };

  final Map<ButtonType, Color> borderColour = {
    ButtonType.primary: AppColours.primaryColour,
    ButtonType.secondary: AppColours.primaryColourLight,
    ButtonType.light: AppColours.light20.withOpacity(0.5),
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width,
      height: 56,
      child: ElevatedButton(
          onPressed: () {
            if(!widget.isLoading) widget.onPressed();
          },
          style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: borderColour[widget.type]!),
                  borderRadius: BorderRadius.circular(16)),
              backgroundColor: backgroundColour[widget.type]),
          child: widget.isLoading ? CircularProgressIndicator(color: foregroundColour[widget.type]) : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(widget.icon != null) widget.icon!,
              Text(
                widget.label,
                style: AppStyles.title3(color: foregroundColour[widget.type]!),
              )
            ],
          )),
    );
  }
}

enum ButtonType { primary, secondary, light }
