import 'package:employee_management_client/model/employee.dart';

class EmployeeData {
  String firstName;
  String lastName;
  String email;
  double baseSalary;
  String password;

  EmployeeData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.baseSalary,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "baseSalary": baseSalary,
      "password": password,
    };
  }
}
