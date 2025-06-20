class IndividualExpense {
  final String uid;
  final String name;
  final String amount;

  IndividualExpense({
    required this.uid,
    required this.name,
    required this.amount,
  });
}

class ExpenseModel {
  final double amount;
  final String description;
  final String date;
  final String time;
  final List<IndividualExpense> individualExpense;
  final IndividualExpense paidBy;
  final String? spaceId;
  final String? spaceName;

  ExpenseModel({
    required this.amount,
    required this.description,
    required this.date,
    required this.time,
    required this.individualExpense,
    this.spaceId,
    this.spaceName,
    required this.paidBy,
  });
}
