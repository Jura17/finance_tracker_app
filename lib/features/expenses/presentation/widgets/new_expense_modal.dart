import 'package:finance_tracker_app/features/expenses/bloc/events/expense_event.dart';
import 'package:finance_tracker_app/features/expenses/data/models/expense.dart';
import 'package:finance_tracker_app/features/expenses/utils/expense_category.dart';
// import 'package:finance_tracker_app/features/expenses/data/repos/database_repo.dart';
import 'package:finance_tracker_app/features/expenses/presentation/widgets/category_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewExpenseModal extends StatefulWidget {
  const NewExpenseModal({
    super.key,
    // required this.repo,
  });

  // final DatabaseRepo repo;

  @override
  State<NewExpenseModal> createState() => _NewExpenseModalState();
}

class _NewExpenseModalState extends State<NewExpenseModal> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController amountCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();

  ExpenseCategory selectedCategory = ExpenseCategory.clothing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 20, left: 16, right: 16),
      child: Column(
        spacing: 10,
        children: [
          Text(
            "Neuer Eintrag",
            style: Theme.of(context).textTheme.displaySmall,
          ),
          Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Row(
                    spacing: 5,
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) return "Bitte Betrag angeben";
                            if (double.tryParse(value) == null) return "Numerischen Wert eingeben";
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          controller: amountCtrl,
                          decoration: InputDecoration(hintText: "Betrag", border: OutlineInputBorder()),
                        ),
                      ),
                      Expanded(
                        child: CategoryDropdown(
                          selectedCategory: selectedCategory,
                          onCategoryChanged: (value) {
                            setState(() {
                              if (value != null) selectedCategory = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Bitte Beschreibung hinzufügen";
                      return null;
                    },
                    controller: descriptionCtrl,
                    maxLines: null,
                    maxLength: 500,
                    decoration: InputDecoration(hintText: "Beschreibung", border: OutlineInputBorder()),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final expense = Expense(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          date: DateTime.now(),
                          category: selectedCategory,
                          description: descriptionCtrl.text,
                          amount: double.parse(amountCtrl.text),
                        );
                        context.read<ExpenseBloc>().add(AddExpense(expense));
                        // widget.repo.addExpense(expense);
                        // setState(() {});
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text("Eintrag anlegen"),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
