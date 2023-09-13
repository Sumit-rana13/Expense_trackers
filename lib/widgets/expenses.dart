import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/modle/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerExpense = [
    Expense(
        title: 'flutter',
        amount: 20.22,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'school',
        amount: 100.22,
        date: DateTime.now(),
        category: Category.work),
  ];

  void _openAddExpense() {
    showModalBottomSheet(
      // isScrollControlled: true,
      context: context,
      builder: (context) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registerExpense.add(expense);
      Navigator.pop(context);
    });

    var snackbar1 = const Text("Expense is added");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: snackbar1,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _RemoveExpense(Expense expense) {
    final expenseIndex = _registerExpense.indexOf(expense);
    setState(() {
      _registerExpense.remove(expense);
    });
    var snackbar = const Text("Expense is deleted");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 3),
      content: snackbar,
      action: SnackBarAction(
          label: "undo",
          onPressed: () {
            setState(() {
              _registerExpense.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No expense is found ! please add Expense"),
    );
    if (_registerExpense.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: _registerExpense,
        onRemoveExpense: _RemoveExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
              onPressed: () {
                _openAddExpense();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                colors: [Colors.red, Colors.yellow])),
        child: Column(
          children: [
            const Text(
              'The Chart',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              // style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(child: mainContent)
          ],
        ),
      ),
    );
  }
}
