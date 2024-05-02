import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utilities/application_constants.dart';
import '../../../utilities/helper_functions.dart';
import '../../camera/screen/camera.dart';
import '../../login/screens/login_screen.dart';
import '../../userData/user_data_screen.dart';
import '../provider/homescreen_provider.dart';
import '../widgets/employee_portal_cell.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<EmployeePortalModel> employeePortalList = [
    EmployeePortalModel(
        moduleImage: "assets/immigration.png", moduleText: "User Data"),
    EmployeePortalModel(
        moduleImage: "assets/qr-code.png", moduleText: "Attendence")
  ];
  String login = '0';
  @override
  void initState() {
    var checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);
    checkoutProvider.getInfo();
    //checkoutProvider.getGeoLocationPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var checkprovider = Provider.of<CheckoutProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              HelperFunctions.getFromPreference("isLogin").then((value) {
                login = value;
                setState(() {});
              });
              if (login == '1') {
                HelperFunctions.showAlert(
                  onCancel: () {
                    // Navigator.pop(context);
                  },
                  context: context,
                  heading: AppConstants.DIALOG_TITLE,
                  description: "Are you sure you want to logout?",
                  btnDoneText: "Yes",
                  btnCancelText: "No",
                  onDone: () {
                    HelperFunctions.clearPreference();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false);
                  },
                );
              }
            },
            child: Container(
              margin: EdgeInsets.only(right: size.width * 0.03),
              child: Image.asset(
                "assets/logout.png",
                width: size.width * 0.06,
                color: Colors.blue,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        title: Text(
          "Employee Portal",
          style: TextStyle(
              fontSize: size.height * 0.025,
              color: Colors.blue[800],
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.05),
            child: Text(
              textAlign: TextAlign.center,
              "${checkprovider.firstname} ${checkprovider.lastname}",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: size.height * 0.03),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8585,
              crossAxisSpacing: size.width * 0.054,
              mainAxisSpacing: size.height * 0.02,
            ),
            itemCount: employeePortalList.length,
            itemBuilder: (ctx, index) {
              return GestureDetector(
                onTap: () {
                  if (index == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserDataScreen(),
                      ),
                    );
                  } else if (index == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CameraScreen(),
                      ),
                    );
                  }
                },
                child: EmployeePortalCell(obj: employeePortalList[index]),
              );
            },
          ),
          // Container(
          //   margin: EdgeInsets.only(
          //       top: size.height * 0.3, bottom: size.height * 0.02),
          //   child: CustomButton(
          //     title: "Logout",
          //     onPress: () {},
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.3),
            child: Image.asset("assets/schuja_it_logo.png",
                width: size.width * 0.6),
          )
        ],
      ),
    );
  }
}
