import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:sit_new/screens/userData/provider/userdata_provider.dart';
import 'package:sit_new/screens/userData/user_data_cell.dart';
import '../../generic_widget/customloader.dart';
class UserDataScreen extends StatefulWidget {
const UserDataScreen({Key? key}) : super(key: key);

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      var userprovider = Provider.of<UserDataProvider>(context, listen: false);
      userprovider.userDataApi(context);
    });
  }

  @override

  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserDataProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    
    return CustomLoader(
      isLoading: Provider.of<UserDataProvider>(context, listen: true).isLoading,
      child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: size.width * 0.06,
              ),
            ),
            backgroundColor: Colors.white,
            title: Text(
              "User Data",
              style: TextStyle(
                  fontSize: size.height * 0.025,
                  color: Colors.blue[800],
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: ListView.builder(
            padding: EdgeInsets.only(top: size.width * 0.05),
            shrinkWrap: true,
            //physics: NeverScrollableScrollPhysics(),
            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //   crossAxisCount: 2,
            //   childAspectRatio: 0.8585,
            //   crossAxisSpacing: size.width * 0.054,
            //   mainAxisSpacing: size.height * 0.0223,
            // ),
            itemCount: userProvider.userdatalist.length,
            itemBuilder: (ctx, index) {
              return UserDataCell(
                obj: userProvider.userdatalist[index],
              );
            },
          )


          // body: ListView(
          //   padding: EdgeInsets.only(top: size.height * 0.05),
          //   children: [
          //     Container(
          //       margin: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Container(
          //             height: size.height * 0.2,
          //             width: size.width * 0.28,
          //             //  color: Colors.red,
          //             decoration: BoxDecoration(
          //               border: Border.all(
          //                 color: Colors.blue,
          //                 width: size.width * 0.005,
          //               ),
          //               borderRadius: BorderRadius.all(
          //                 Radius.circular(size.width * 0.03),
          //               ),
          //               color: Colors.white,
          //               // boxShadow: [
          //               //   BoxShadow(
          //               //     spreadRadius: 2,
          //               //     blurRadius: 1,
          //               //     offset: Offset(0, 5),
          //               //     color: Colors.black.withOpacity(0.2),
          //               //   ),
          //               // ],
          //             ),
          //             child: Column(
          //               children: [
          //                 Container(
          //                   margin:
          //                       EdgeInsets.symmetric(vertical: size.height * 0.02),
          //                   child: Text(
          //                     "Check In",
          //                     style: TextStyle(
          //                       fontSize: size.height * 0.023,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Container(
          //             height: size.height * 0.2,
          //             width: size.width * 0.28,
          //             // color: Colors.blue,
          //             decoration: BoxDecoration(
          //               border: Border.all(
          //                 color: Colors.blue,
          //                 width: size.width * 0.005,
          //               ),
          //               borderRadius: BorderRadius.all(
          //                 Radius.circular(size.width * 0.03),
          //               ),
          //               color: Colors.white,
          //               // boxShadow: [
          //               //   BoxShadow(
          //               //     spreadRadius: 2,
          //               //     blurRadius: 1,
          //               //     offset: Offset(0, 5),
          //               //     color: Colors.black.withOpacity(0.2),
          //               //   ),
          //               // ],
          //             ),
          //             child: Column(
          //               children: [
          //                 Container(
          //                   margin:
          //                       EdgeInsets.symmetric(vertical: size.height * 0.02),
          //                   child: Text(
          //                     "Check Out",
          //                     style: TextStyle(
          //                       fontSize: size.height * 0.023,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Container(
          //             height: size.height * 0.2,
          //             width: size.width * 0.28,
          //             //color: Colors.green,
          //             decoration: BoxDecoration(
          //               border: Border.all(
          //                 color: Colors.blue,
          //                 width: size.width * 0.005,
          //               ),
          //               borderRadius: BorderRadius.all(
          //                 Radius.circular(size.width * 0.03),
          //               ),
          //               color: Colors.white,
          //               // boxShadow: [
          //               //   BoxShadow(
          //               //     spreadRadius: 2,
          //               //     blurRadius: 1,
          //               //     offset: Offset(0, 5),
          //               //     color: Colors.black.withOpacity(0.2),
          //               //   ),
          //               // ],
          //             ),
          //             child: Column(
          //               children: [
          //                 Container(
          //                   margin:
          //                       EdgeInsets.symmetric(vertical: size.height * 0.02),
          //                   child: Text(
          //                     "Total Time",
          //                     style: TextStyle(
          //                       fontSize: size.height * 0.023,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          ),
    );
  }
}
