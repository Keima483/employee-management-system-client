import 'package:employee_management_client/model/bonus.dart';

class Employee {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  int? daysPresent;
  double? baseSalary;
  List<Bonus>? bonuses;

  Employee(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.daysPresent,
      this.baseSalary,
      this.bonuses});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    daysPresent = json['daysPresent'];
    baseSalary = json['baseSalary'];
    if (json['bonuses'] != null) {
      bonuses = <Bonus>[];
      json['bonuses'].forEach((v) {
        bonuses!.add(Bonus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'daysPresent': daysPresent,
      'baseSalary': baseSalary,
    };

    if (bonuses != null) {
      data['bonuses'] = bonuses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
