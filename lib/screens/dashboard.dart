import 'package:employee_management_client/controller/employee_detail_controller.dart';
import 'package:employee_management_client/controller/employee_list_controller.dart';
import 'package:employee_management_client/controller/login_controller.dart';
import 'package:employee_management_client/model/bonus_data.dart';
import 'package:employee_management_client/model/employee_data.dart';
import 'package:employee_management_client/screens/comman/login_button.dart';
import 'package:employee_management_client/screens/comman/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);

  final loginController = Get.put(
    LoginController(),
  );

  final employeeListController = Get.put(
    EmployeeListController(),
  );

  final employeeDetailController = Get.put(
    EmployeeDetailController(),
  );

  final _formKey = GlobalKey<FormState>();

  var firstnameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var baseSalaryController = TextEditingController();
  var passwordController = TextEditingController();
  var bonusNameController = TextEditingController();
  var bonusAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/bg2.jpg',
              ),
              fit: BoxFit.cover),
        ),
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Obx(() {
                      return ListView.builder(
                        itemCount: employeeListController.employees.length,
                        itemBuilder: (BuildContext context, int index) {
                          var employee =
                              employeeListController.employees[index];
                          return GestureDetector(
                            onTap: () {
                              employeeDetailController
                                  .getEmployeeData(employee.id!);
                            },
                            child: Card(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.person,
                                    size: 50,
                                  ),
                                  title: Text(
                                    '${employee.firstName} ${employee.lastName}',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    employee.email!,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 60,
                        child: FittedBox(
                          child: FloatingActionButton.extended(
                            onPressed: () {
                              addEmployeePopup(context);
                            },
                            label: Row(children: const [
                              Icon(
                                Icons.add,
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Add Employee',
                                style: TextStyle(fontSize: 20),
                              )
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Obx(() {
                  return employeeDetailController.isPresent.value
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              height: size.height * 0.33,
                              width: size.width,
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 120,
                                    child: Icon(
                                      Icons.person,
                                      size: 160,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(height: 10),
                                        Text(
                                          "${employeeDetailController.employee!.value.firstName} ${employeeDetailController.employee!.value.lastName}",
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          "${employeeDetailController.employee!.value.email}",
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          "₹ ${employeeDetailController.employee!.value.baseSalary}",
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          "${employeeDetailController.employee!.value.daysPresent} days present",
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  height: size.height * 0.55,
                                  width: size.width,
                                  child: ListView.builder(
                                    itemCount: employeeDetailController
                                        .employee!.value.bonuses!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var bonus = employeeDetailController
                                          .employee!.value.bonuses![index];
                                      return Card(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: ListTile(
                                            leading: const Icon(
                                              Icons.currency_rupee_sharp,
                                              size: 50,
                                            ),
                                            title: Text(
                                              bonus.name!,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                            subtitle: Text(
                                              bonus.amount!.toString(),
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 30,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SizedBox(
                                      height: 50,
                                      child: FittedBox(
                                        child: FloatingActionButton.extended(
                                          onPressed: () {
                                            addBonusPopUp(context);
                                          },
                                          label: Row(children: const [
                                            Icon(
                                              Icons.add,
                                              size: 30,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Add Bonus',
                                              style: TextStyle(fontSize: 20),
                                            )
                                          ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      : Container();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addBonusPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 400, vertical: 120),
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          child: Material(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Give Bonus',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  LoginTextField(
                    controller: bonusNameController,
                    lable: 'Name',
                    validator: _validate,
                  ),
                  LoginTextField(
                    controller: bonusAmountController,
                    lable: 'amount',
                    validator: _validate,
                  ),
                  LoginButton(
                    label: 'Done',
                    onPress: () async {
                      if (_formKey.currentState!.validate()) {
                        var bonusData = BonusData(
                          name: bonusNameController.text,
                          amount: double.parse(
                            bonusAmountController.text,
                          ),
                        );
                        await employeeDetailController.addBonus(
                          bonusData,
                        );
                        bonusNameController.clear();
                        bonusAmountController.clear();
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void addEmployeePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 400, vertical: 120),
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          child: Material(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add Employee',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  LoginTextField(
                    controller: firstnameController,
                    lable: 'First Name',
                    validator: _validate,
                  ),
                  LoginTextField(
                    controller: lastNameController,
                    lable: 'Last Name',
                    validator: _validate,
                  ),
                  LoginTextField(
                    controller: emailController,
                    lable: 'Email',
                    validator: _validate,
                  ),
                  LoginTextField(
                    controller: baseSalaryController,
                    lable: 'Base Salary',
                    validator: _validate,
                  ),
                  LoginTextField(
                    controller: passwordController,
                    lable: 'Password',
                    validator: _validate,
                  ),
                  LoginButton(
                    label: 'Add Employee',
                    onPress: () async {
                      if (_formKey.currentState!.validate()) {
                        var employeeDetail = EmployeeData(
                          firstName: firstnameController.text,
                          lastName: lastNameController.text,
                          email: emailController.text,
                          baseSalary: double.parse(baseSalaryController.text),
                          password: passwordController.text,
                        );
                        await employeeListController.addEmployee(
                          loginController.company!.value.id!,
                          employeeDetail,
                        );
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Something';
    }
    return null;
  }
}
