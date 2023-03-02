class Bonus {
  int? id;
  String? name;
  double? amount;

  Bonus({this.id, this.name, this.amount});

  Bonus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'amount': amount
    };
    return data;
  }
}
