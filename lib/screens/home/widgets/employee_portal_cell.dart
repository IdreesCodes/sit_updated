import 'dart:ui';

import 'package:flutter/material.dart';


import '../../../utilities/color_constants.dart';

class EmployeePortalCell extends StatelessWidget {
  EmployeePortalModel obj;
  EmployeePortalCell({required this.obj});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.12,
      width: size.height * 0.12,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 1,
              offset: Offset(0, 5),
              color: Colors.black.withOpacity(0.2),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            obj.moduleText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size.height * 0.022,
              fontWeight: FontWeight.bold,
              color: ColorConstants.primary,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Image.asset(
            obj.moduleImage,
            height: size.height * 0.09,
          ),
        ],
      ),
    );
  }
}

class EmployeePortalModel {
  String moduleText;
  String moduleImage;

  EmployeePortalModel({
    this.moduleImage = '',
    this.moduleText = '',
  });
}
