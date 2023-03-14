import 'dart:io';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:radiology_centers/pages/user/user_home.dart';

class BookRay extends StatefulWidget {
  String centerName;
  String userName;
  String userPhone;
  String userUid;
  String type;
  static const routeName = '/bookRay';
  BookRay({
    required this.centerName,
    required this.userName,
    required this.userPhone,
    required this.userUid,
    required this.type,
  });

  @override
  State<BookRay> createState() => _BookRayState();
}

class _BookRayState extends State<BookRay> {
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              top: 20.h,
            ),
            child: Padding(
              padding: EdgeInsets.only(right: 10.w, left: 10.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset('assets/images/center.jfif'),
                    SizedBox(
                      height: 40.h,
                    ),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        controller: dateController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xfff8a55f), width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'تاريخ الحجز',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0.0),
                        elevation: 5,
                      ),
                      onPressed: () async {
                        String date = dateController.text.trim();

                        if (date.isEmpty) {
                          CherryToast.info(
                            title: Text('Please Fill all Fields'),
                            actionHandler: () {},
                          ).show(context);
                          return;
                        }

                        User? user = FirebaseAuth.instance.currentUser;

                        if (user != null) {
                          String uid = user.uid;

                          DatabaseReference companyRef = FirebaseDatabase
                              .instance
                              .reference()
                              .child('bookings');

                          String? id = companyRef.push().key;

                          await companyRef.child(id!).set({
                            'id': id,
                            'date': date,
                            'userName': widget.userName,
                            'userPhone': widget.userPhone,
                            'userUid': widget.userUid,
                            'centerName': widget.centerName,
                            'type': widget.type,
                          });
                        }
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('ادفع الأن'),
                                  content: Container(
                                    height: 100.h,
                                    child: Text('اختر طريقة الدفع'),
                                  ),
                                  actions: [
                                    ElevatedButton.icon(
                                      icon: const Icon(Icons.credit_card,
                                          size: 18),
                                      label: Text('بطاقة الأئتمان'),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Notice"),
                                              content: SizedBox(
                                                height: 65.h,
                                                child: TextField(
                                                  
                                                  decoration: InputDecoration(
                                                    fillColor:
                                                        HexColor('#155564'),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color(0xfff8a55f),
                                                          width: 2.0),
                                                    ),
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText: 'ادخل رقم الفيزا',
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    primary:
                                                        HexColor('#6bbcba'),
                                                  ),
                                                  child: Text("دفع"),
                                                  onPressed: () {
                                                    Navigator.pushNamed(context,
                                                        UserHome.routeName);
                                                  },
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    ElevatedButton.icon(
                                      icon: const Icon(Icons.credit_card,
                                          size: 18),
                                      label: Text('كاش'),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Notice"),
                                              content: Text(
                                                  "تم الحجز وسيتم الدفع كاش فى المركز"),
                                              actions: [
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    primary:
                                                        HexColor('#6bbcba'),
                                                  ),
                                                  child: Text("Ok"),
                                                  onPressed: () {
                                                    Navigator.pushNamed(context,
                                                        UserHome.routeName);
                                                  },
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ));
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xfff1665f), Color(0xFF2661FA)]),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          constraints: const BoxConstraints(minWidth: 88.0),
                          child: const Text('دفع الأن',
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
