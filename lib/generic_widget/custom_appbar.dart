import 'package:flutter/material.dart';
import '../utilities/color_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  Color appbarTitleColor;
  Color leftIconColor;
  Widget appbarTitle;
  VoidCallback? leftIconAction;
  String leftIcon;
  List<Widget>? actionsWidget = [];
  Color appabarColor;

  CustomAppBar({
    required this.appbarTitle,
    this.leftIconColor = Colors.white,
    this.appbarTitleColor = ColorConstants.secondary,
    this.appabarColor = ColorConstants.primary,
    this.leftIconAction,
    this.leftIcon = "assets/images/back_arrow_ios.png",
    this.actionsWidget,
  });
  double height = 0, width = 0;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppBar(
        leadingWidth: size.width * 0.08,
        backgroundColor: appabarColor,
        leading: GestureDetector(
          onTap: () {
            if (leftIconAction != null) {
              leftIconAction;
            } else {
              Navigator.pop(context);
            }
          },
          child: Container(
            margin: EdgeInsets.only(left: size.width * 0.02),
            child: Image.asset(
              leftIcon,
              height: size.height * 0.02,
              width: size.width * 0.04,
              color: leftIconColor,
            ),
          ),
        ),
        elevation: 0,
        actions: actionsWidget,
        centerTitle: true,
        title: appbarTitle);
  }
}
