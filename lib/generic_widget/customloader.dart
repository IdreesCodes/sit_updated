import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class CustomLoader extends StatelessWidget {
  Color bgcolor;
  Color loaderColor;
  final bool? isLoading;
  final Widget? child;
  CustomLoader(
      {this.child,
      this.isLoading,
      this.bgcolor = Colors.black12,
      this.loaderColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return isLoading!
        ? Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                child: Container(
                  width: width,
                  height: height,
                  child: child,
                ),
              ),
              Positioned(
                child: Align(
                  alignment: FractionalOffset.center,
                  child: Container(
                    width: width,
                    height: height,
                    color: bgcolor,
                    child: Padding(
                      padding: const EdgeInsets.all(128.0),
                      child: Center(
                        child: Lottie.asset("assets/loader_animation.json"),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Container(
            child: child,
          );
  }
}
