import 'dart:convert';
import 'package:employee_management_client/model/employee_data.dart';
import 'package:flutter/material.dart';
import 'package:employee_management_client/model/employee.dart';
import 'package:employee_management_client/utils/endpoints.dart' as endpoints;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EmployeeListController extends GetxController {
  var employees = <Employee>[].obs;

  Future<void> getEmployees(int id) async {
    var response = await http.get(
      Uri.parse(
        '${endpoints.companyEmployees}?id=$id',
      ),
    );
    if (response.statusCode == 200) {
      var list = <Employee>[];
      var jsonList = jsonDecode(response.body);
      for (var item in jsonList) {
        list.add(Employee.fromJson(item));
      }
      employees.value = list;
      notifyChildrens();
    } else {
      Get.snackbar(
        "Error!",
        'Some Problem Occured',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> addEmployee(int id, EmployeeData employeeData) async {
    var response = await http.post(
      Uri.parse(
        '${endpoints.companyEmployees}?id=$id',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        employeeData.toJson(),
      ),
    );
    if (response.statusCode == 200) {
      await getEmployees(id);
    } else {
      Get.snackbar(
        "Error!",
        "Some Error Occured",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
