import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  VoidCallback onPress;
  bool showImage;
  CustomButton({
    this.showImage = false,
    required this.title,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // TODO: implement build
    return Container(
      height: size.height * 0.0479,
      width: size.width * 0.57,
      // color: Colors.black,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        pressedOpacity: 0.8,
        borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.width * 0.135),
        onPressed: onPress,
        child: showImage == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: size.width * 0.02),
                    child: Image.asset(
                      "assets/images/upload (1) 1.png",
                      height: size.height * 0.02,
                    ),
                  )
                ],
              )
            : Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.height * 0.02,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
        color: Colors.orange,
      ),
    );
  }
}
