class BonusData {
  String name;
  double amount;

  BonusData({
    required this.name,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
    };
  }
}
