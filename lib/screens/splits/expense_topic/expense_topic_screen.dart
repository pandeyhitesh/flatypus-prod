import 'package:flatypus/common/widgets/base_layout.dart';
import 'package:flutter/material.dart';

class ExpenseTopicScreen extends StatelessWidget {
  const ExpenseTopicScreen({super.key});

  AppBar get _appBar => AppBar(title: const Text('Expense Topic'), centerTitle: true);

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      showAppBar: true,
        appBar: _appBar,
        body: Column());
  }
}
