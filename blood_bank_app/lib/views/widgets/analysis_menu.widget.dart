import 'package:flutter/material.dart';

class AnalysisMenu extends StatelessWidget {
  final Function(String?)? onChanged;
  final String? value;
  final List<DropdownMenuItem<String>> items;

  AnalysisMenu({required this.onChanged, this.value, required this.items});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: const Text("Selecione"),
      isExpanded: true,
      onChanged: onChanged,
      items: items,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
