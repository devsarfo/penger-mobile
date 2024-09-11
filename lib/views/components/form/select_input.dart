import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:penger/resources/app_colours.dart';

class SelectInputComponent<T> extends StatefulWidget {
  final bool isRequired;
  final bool isEnabled;
  final String label;
  final String? error;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final List<T> items;
  final T? selectedItem;
  final Function(T?) onChanged;

  const SelectInputComponent({super.key, required this.label, this.onFieldSubmitted, this.focusNode, this.isRequired = false, this.isEnabled = true, this.error, required this.items, required this.onChanged, this.selectedItem});

  @override
  State<SelectInputComponent<T>> createState() => _SelectInputComponentState<T>();
}

class _SelectInputComponentState<T> extends State<SelectInputComponent<T>> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      popupProps: const PopupProps.bottomSheet(
        showSelectedItems: true,
      ),
      items: widget.items,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
            labelText: widget.label,
            errorText: widget.error,
            labelStyle: TextStyle(color: AppColours.light20),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                BorderSide(color: AppColours.light20.withOpacity(0.5))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                BorderSide(color: AppColours.light20.withOpacity(0.5))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: AppColours.primaryColour)),
            ),
      ),
      onChanged: widget.onChanged,
      selectedItem: widget.selectedItem,
    );
  }

  void togglePassword()  => setState(() {
    showPassword = !showPassword;
  });
}
