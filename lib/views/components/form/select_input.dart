import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:penger/resources/app_colours.dart';
import 'package:penger/resources/app_strings.dart';

class SelectInputComponent<T> extends StatefulWidget {
  final bool isRequired;
  final bool isEnabled;
  final String label;
  final String? error;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final List<T> items;
  final T? selectedItem;
  final Function(T? value) onChanged;
  final bool Function(T, T)? compareFn;
  final bool? showSearchBox;

  const SelectInputComponent({super.key, required this.label, this.onFieldSubmitted, this.focusNode, this.isRequired = false, this.isEnabled = true, this.error, required this.items, required this.onChanged, this.selectedItem, this.compareFn, this.showSearchBox});

  @override
  State<SelectInputComponent<T>> createState() => _SelectInputComponentState<T>();
}

class _SelectInputComponentState<T> extends State<SelectInputComponent<T>> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      popupProps: PopupProps.modalBottomSheet(
        showSelectedItems: true,
        showSearchBox: widget.showSearchBox ?? false,
        searchFieldProps: const TextFieldProps(padding: EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 24))
      ),
      items: widget.items,
      compareFn: widget.compareFn,
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
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if(widget.isRequired && value == null){
          return AppStrings.inputIsRequired.replaceAll(":input", widget.label);
        }

        return null;
      },
      enabled: widget.isEnabled,
    );
  }

  void togglePassword()  => setState(() {
    showPassword = !showPassword;
  });
}
