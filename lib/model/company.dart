import 'package:employee_management_client/model/employee.dart';

class Company {
  int? id;
  String? name;
  String? ipAddress;
  String? email;
  List<Employee>? employees;

  Company({this.id, this.name, this.ipAddress, this.email, this.employees});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ipAddress = json['ipAddress'];
    email = json['email'];
    employees = <Employee>[];
    if (json['employees'] != null) {
      json['employees'].forEach((v) {
        employees!.add(Employee.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'ipAddress': ipAddress,
      'email': email,
    };
    if (employees != null) {
      data['employees'] = employees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
