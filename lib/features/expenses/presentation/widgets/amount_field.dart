import 'package:flutter/material.dart';

class AmountField extends StatelessWidget {
  const AmountField({
    super.key,
    required this.amountCtrl,
  });

  final TextEditingController amountCtrl;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        autocorrect: false,
        enableSuggestions: false,
        inputFormatters: [],
        validator: (value) {
          if (value == null || value.isEmpty) return "Bitte Betrag angeben";
          final normalized = value.replaceAll(',', '.');
          if (double.tryParse(normalized) == null) return "Numerischen Wert eingeben";
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        controller: amountCtrl,
        decoration: InputDecoration(hintText: "Betrag"),
      ),
    );
  }
}
