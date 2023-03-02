import 'package:employee_management_client/controller/login_controller.dart';
import 'package:employee_management_client/screens/comman/login_button.dart';
import 'package:employee_management_client/screens/comman/login_text_field.dart';
import 'package:employee_management_client/screens/dashboard.dart';
import 'package:employee_management_client/screens/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
            image: AssetImage('assets/images/bg1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            elevation: 100,
            child: Container(
              height: size.height / 1.8,
              width: size.height / 1.3,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'LogIn',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    LoginTextField(
                      controller: emailController,
                      lable: 'Email',
                      validator: _validate,
                    ),
                    LoginTextField(
                      controller: passwordController,
                      lable: 'Password',
                      isPassword: true,
                      validator: _validate,
                    ),
                    LoginButton(
                      label: 'Login',
                      onPress: () async {
                        if (_formKey.currentState!.validate()) {
                          await loginController.login(
                            emailController.text,
                            passwordController.text,
                          );
                          if (loginController.company != null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Dashboard(),
                              ),
                            );
                          }
                        }
                      },
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'New here? ',
                        style: TextStyle(
                            fontSize: 20, color: Colors.grey.shade700),
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUpScreen(),
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
    );
  }
}
