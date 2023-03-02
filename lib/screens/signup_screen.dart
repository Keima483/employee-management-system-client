import 'package:employee_management_client/controller/login_controller.dart';
import 'package:employee_management_client/model/company_data.dart';
import 'package:employee_management_client/networking/email_taken.dart';
import 'package:employee_management_client/screens/comman/login_button.dart';
import 'package:employee_management_client/screens/comman/login_text_field.dart';
import 'package:employee_management_client/screens/dashboard.dart';
import 'package:employee_management_client/screens/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final ipAddressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final loginController = Get.put(
    LoginController(),
  );

  final _formKey = GlobalKey<FormState>();

  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Something';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg3.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  elevation: 100,
                  child: Container(
                    height: size.height / 1.35,
                    width: size.height / 1.3,
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          LoginTextField(
                            controller: nameController,
                            lable: "Company Name",
                            validator: _validate,
                          ),
                          LoginTextField(
                            controller: emailController,
                            lable: "Company email",
                            validator: _validate,
                          ),
                          LoginTextField(
                            controller: ipAddressController,
                            lable: "Wifi Ip Address",
                            validator: _validate,
                          ),
                          LoginTextField(
                            controller: passwordController,
                            lable: "Password",
                            validator: _validate,
                            isPassword: true,
                          ),
                          LoginTextField(
                            controller: confirmPasswordController,
                            lable: "Confirm password",
                            isPassword: true,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Something';
                              }
                              if (passwordController.text !=
                                  confirmPasswordController.text) {
                                return 'password missmatching';
                              }
                              return null;
                            },
                          ),
                          LoginButton(
                            label: 'Sign Up',
                            onPress: () async {
                              if (_formKey.currentState!.validate()) {
                                if (await isEmailAvailable(
                                    emailController.text)) {
                                  var data = CompanyData(
                                    name: nameController.text,
                                    email: emailController.text,
                                    ipAddress: ipAddressController.text,
                                    password: passwordController.text,
                                  );
                                  await loginController.signUp(data);
                                  if (loginController.company != null) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Dashboard(),
                                      ),
                                    );
                                  }
                                } else {
                                  Get.snackbar(
                                    "Error!",
                                    'Email already exist',
                                    backgroundColor: Colors.red,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                }
                              }
                            },
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Already a menber? ',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.grey.shade700),
                              children: [
                                TextSpan(
                                  text: 'Log In',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginScreen(),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Expanded(
              child: SizedBox(),
              flex: 2,
            )
          ],
        ),
      ),
    );
  }
}
