import 'package:finance_tracker_app/features/expenses/bloc/expense_bloc.dart';
import 'package:finance_tracker_app/features/expenses/bloc/expense_event.dart';
import 'package:finance_tracker_app/features/expenses/bloc/expense_state.dart';
import 'package:finance_tracker_app/features/expenses/presentation/widgets/amount_field.dart';
import 'package:finance_tracker_app/features/expenses/presentation/widgets/confirm_button.dart';
import 'package:finance_tracker_app/features/expenses/presentation/widgets/description_field.dart';
import 'package:finance_tracker_app/core/utils/expense_category.dart';
import 'package:finance_tracker_app/features/expenses/presentation/widgets/category_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewExpenseModal extends StatefulWidget {
  const NewExpenseModal({super.key});

  @override
  State<NewExpenseModal> createState() => _NewExpenseModalState();
}

class _NewExpenseModalState extends State<NewExpenseModal> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController amountCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();

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
                      BlocBuilder<ExpenseBloc, ExpenseState>(builder: (context, state) {
                        return CategoryDropdown(
                          selectedCategory: state.newExpenseCategory,
                          onCategoryChanged: (value) {
                            if (value != null) {
                              context.read<ExpenseBloc>().add(NewExpenseCategoryChanged(value));
                            }
                          },
                        );
                      }),
                    ],
                  ),
                  DescriptionField(descriptionCtrl: descriptionCtrl),
                  BlocBuilder<ExpenseBloc, ExpenseState>(builder: (context, state) {
                    return ConfirmButton(
                      formKey: formKey,
                      selectedCategory: state.newExpenseCategory,
                      descriptionCtrl: descriptionCtrl,
                      amountCtrl: amountCtrl,
                    );
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
