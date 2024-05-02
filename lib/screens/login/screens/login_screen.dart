// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generic_widget/custom_textfield.dart';
import '../../../generic_widget/customloader.dart';
import '../../../utilities/color_constants.dart';
import '../provider/login_provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool passwordHide = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return CustomLoader(
      isLoading: Provider.of<LoginProvider>(context, listen: true).isLoading,
      child: Scaffold(
        body: AutofillGroup(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: size.height * 0.1, bottom: size.height * 0.1),
                child: Image.asset(
                  "assets/schuja_it_logo.png",
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03,
                  vertical: size.height * 0.05,
                ),
                child: MyCustomTextFeild(
                  heading: "UserName",
                  controller: emailController,
                  hintText: "",
                  hidePassword: false,
                  textColor: Colors.black,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03,
                ),
                child: MyCustomTextFeild(
                  heading: "Password",
                  controller: passwordController,
                  hintText: "",
                  hidePassword: passwordHide == true ? false : true,
                  textColor: Colors.black,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        passwordHide = !passwordHide;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: size.height * 0.01),
                      child: Icon(
                        passwordHide == true
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: ColorConstants.primary,
                        size: size.height * 0.025,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<LoginProvider>(context, listen: false)
                      .loginAction(
                    context,
                    emailController.text,
                    passwordController.text,
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: size.height * 0.1,
                    left: size.width * 0.2,
                    right: size.width * 0.2,
                  ),
                  // width: size.width * 0.06,
                  height: size.height * 0.07,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(size.width * 0.03),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: size.height * 0.025,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
