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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) return "Bitte Beschreibung hinzufügen";
        return null;
      },
      controller: descriptionCtrl,
      maxLines: 3,
      maxLength: 70,
      decoration: InputDecoration(
        hintText: "Beschreibung",
        border: OutlineInputBorder(),
      ),
    );
  }
}
