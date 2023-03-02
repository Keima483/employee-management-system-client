import 'dart:convert';

import 'package:employee_management_client/model/bonus_data.dart';
import 'package:employee_management_client/model/employee.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:employee_management_client/utils/endpoints.dart' as endpoints;

class EmployeeDetailController extends GetxController {
  Rx<Employee>? employee;
  RxBool isPresent = false.obs;
  int? id;

  Future<void> getEmployeeData(int id) async {
    this.id = id;
    var response = await http.get(
      Uri.parse(
        '${endpoints.companyEmployees}/$id',
      ),
    );
    if (response.statusCode == 200) {
      var tempEmployee = Employee.fromJson(jsonDecode(response.body));
      if (employee == null) {
        employee = Rx(tempEmployee);
      } else {
        employee!.value = tempEmployee;
      }
      isPresent(true);
      notifyChildrens();
    } else {
      Get.snackbar(
        "Error!",
        'Some Can\'t load data',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> updateEmployee() async {
    await getEmployeeData(id!);
  }

  Future<void> addBonus(BonusData bonusData) async {
    var response = await http.post(
      Uri.parse(
        '${endpoints.employeeBonus}?id=$id',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        bonusData.toJson(),
      ),
    );
    if (response.statusCode == 200) {
      updateEmployee();
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
