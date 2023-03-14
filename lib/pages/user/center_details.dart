import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:radiology_centers/pages/user/center_rays.dart';

class CenterDetails extends StatefulWidget {
  String name;
  String address;
  String imageUrl;
  String phoneNumber;
  String workTime;
  String userName;
  String userUid;
  String userPhone;
  CenterDetails({
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.phoneNumber,
    required this.workTime,
    required this.userName,
    required this.userUid,
    required this.userPhone,
  });

  @override
  State<CenterDetails> createState() => _CenterDetailsState();
}

class _CenterDetailsState extends State<CenterDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
              backgroundColor: Color(0xFF2661FA),
              title: Text('${widget.name}')),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 15.h, right: 15.w, left: 15.w),
              child: Column(children: [
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: 15, bottom: 15),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 15.w),
                              child: Image.network('${widget.imageUrl}'),
                            ),
                          ],
                        )),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'العنوان : ${widget.address}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'رقم الهاتف: ${widget.phoneNumber}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'مواعيد العمل : ${widget.workTime}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: InkWell(
                    onTap: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CenterRays(
                          centerName: '${widget.name}',
                          userName: '${widget.userName}',
                          userUid: '${widget.userUid}',
                          userPhone: '${widget.userPhone}',
                        );
                      }));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: size.width * 0.5,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          gradient: new LinearGradient(colors: [
                            Color.fromARGB(255, 255, 136, 34),
                            Color.fromARGB(255, 255, 177, 41)
                          ])),
                      padding: const EdgeInsets.all(0),
                      child: Text(
                        "حجز أشعة",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
