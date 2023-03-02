import 'dart:convert';

import 'package:employee_management_client/controller/employee_list_controller.dart';
import 'package:employee_management_client/model/company.dart';
import 'package:employee_management_client/model/company_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:employee_management_client/utils/endpoints.dart' as endpoints;

class LoginController extends GetxController {
  Rx<Company>? company;
  final employeeListController = Get.put(
    EmployeeListController(),
  );

  Future<void> login(String email, String password) async {
    var response = await http.post(
      Uri.parse(endpoints.login),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      company = Company.fromJson(jsonDecode(response.body)).obs;
      employeeListController.employees.value = company!.value.employees!;
      notifyChildrens();
      print(company!.value.toJson());
    } else {
      Get.snackbar(
        "Error!",
        jsonDecode(response.body)['message'],
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> signUp(CompanyData companyData) async {
    var response = await http.post(
      Uri.parse(endpoints.signup),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        companyData.toJson(),
      ),
    );
    if (response.statusCode == 200) {
      company = Company.fromJson(jsonDecode(response.body)).obs;
      employeeListController.employees.value = company!.value.employees!;
      notifyChildrens();
      print(company!.value.toJson());
    } else {
      Get.snackbar(
        "Error!",
        jsonDecode(response.body)['message'],
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
