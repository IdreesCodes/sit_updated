import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utilities/helper_functions.dart';
import '../login/provider/login_provider.dart';
import '../login/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  dynamic userName;
  dynamic password;

  void startTimer() async {
    userName = await HelperFunctions.getFromPreference("username");
    password = await HelperFunctions.getFromPreference("password");
    Future.delayed(const Duration(seconds: 5), () {
      HelperFunctions.getFromPreference("isLogin").then((value) {
        print(value);
        if (value == "1") {
          if (userName == "") {
            userName = emailController.text;
            password = passwordController.text;
          }
          Provider.of<LoginProvider>(context, listen: false)
              .callLoginApi(context, userName, password);
        } else {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return LoginScreen();
          }));
        }
      });
    });
  }

  late AnimationController controller;
  @override
  Widget build(BuildContext context) {
    // startTimer();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/schuja_it_logo.png',
        ),
      ),
    );
  }
}
