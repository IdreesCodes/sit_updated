import 'package:flutter/material.dart';

class UserDataCell extends StatelessWidget {
  UserDataModel obj;
  UserDataCell({required this.obj});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.03, vertical: size.height * 0.02),
      //  height: size.height * 0.25,
      width: size.width * 0.3,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
          width: size.width * 0.005,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(size.width * 0.03),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 3),
            color: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                vertical: size.height * 0.02, horizontal: size.width * 0.03),
            child: Text(
              obj.checkIn == '' ? "Check In: ---" : "Check In: " + obj.checkIn,
              maxLines: 3,
              style: TextStyle(
                fontSize: size.height * 0.023,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: size.height * 0.02, horizontal: size.width * 0.03),
            child: Text(
              obj.checkOut == ''
                  ? "Check Out: ---"
                  : "Check Out: " + obj.checkOut,
              maxLines: 3,
              style: TextStyle(
                fontSize: size.height * 0.023,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: size.height * 0.02, horizontal: size.width * 0.03),
            child: Text(
              obj.totalTime == ''
                  ? "Total Time: ---"
                  : "Total Time: " + obj.totalTime,
              maxLines: 3,
              style: TextStyle(
                fontSize: size.height * 0.023,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserDataModel {
  String checkIn;
  String checkOut;
  String totalTime;

  UserDataModel({
    this.checkIn = '',
    this.checkOut = '',
    this.totalTime = '',
  });
  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      checkIn: json['checkInTime'] == null ? "" : json['checkInTime'],
      checkOut:
          json['checkOutTime'] == null ? "" : json['checkOutTime'].toString(),
      totalTime: json['totalTime'] == null ? "" : json['totalTime'].toString(),
    );
  }
}
