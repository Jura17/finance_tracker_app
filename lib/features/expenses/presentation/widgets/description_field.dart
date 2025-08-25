import 'package:flutter/material.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({
    super.key,
    required this.descriptionCtrl,
  });

  final TextEditingController descriptionCtrl;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) return "Bitte Beschreibung hinzufügen";
        return null;
      },
      controller: descriptionCtrl,
      maxLines: null,
      maxLength: 500,
      decoration: InputDecoration(hintText: "Beschreibung", border: OutlineInputBorder()),
    );
  }
}
