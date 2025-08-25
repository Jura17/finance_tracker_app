import 'package:finance_tracker_app/features/expenses/presentation/widgets/amount_field.dart';
import 'package:finance_tracker_app/features/expenses/presentation/widgets/confirm_button.dart';
import 'package:finance_tracker_app/features/expenses/presentation/widgets/description_field.dart';
import 'package:finance_tracker_app/core/utils/expense_category.dart';
import 'package:finance_tracker_app/features/expenses/presentation/widgets/category_dropdown.dart';
import 'package:flutter/material.dart';

class NewExpenseModal extends StatefulWidget {
  const NewExpenseModal({super.key});

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
            style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 10,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      AmountField(amountCtrl: amountCtrl),
                      CategoryDropdown(
                        selectedCategory: selectedCategory,
                        onCategoryChanged: (value) {
                          if (value != null) selectedCategory = value;
                        },
                      ),
                    ],
                  ),
                  DescriptionField(descriptionCtrl: descriptionCtrl),
                  ConfirmButton(
                    formKey: formKey,
                    selectedCategory: selectedCategory,
                    descriptionCtrl: descriptionCtrl,
                    amountCtrl: amountCtrl,
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
