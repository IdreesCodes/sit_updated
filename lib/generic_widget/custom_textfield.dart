import 'package:flutter/material.dart';
import '../utilities/color_constants.dart';

typedef void CustomTextFieldOnChangeCallBack(String text);

class MyCustomTextFeild extends StatelessWidget {
  Widget? suffixIcon;
  TextEditingController controller;
  Color textColor;
  bool hidePassword;
  String heading;
  String hintText;
  TextInputType keyboardType;
  CustomTextFieldOnChangeCallBack? onChanged;
  MyCustomTextFeild({
    Key? key,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    required this.controller,
    this.onChanged,
    this.heading = '',
    required this.hintText,
    required this.hidePassword,
    required this.textColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(
            color: ColorConstants.primary,
            fontSize: height * 0.023,
          ),
        ),
        Container(
          // margin: EdgeInsets.only(bottom: height * 0.023),
          height: height * 0.04,
          //width: width * 0.8,
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            obscureText: hidePassword,
            keyboardType: keyboardType,
            style: TextStyle(
              fontSize: height * 0.022,
              color: textColor,
            ),
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueAccent,
                ),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              hintStyle: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w300,
                fontSize: height * 0.02,
              ),
              hintText: hintText,
            ),
          ),
        ),
      ],
    );
  }
}
