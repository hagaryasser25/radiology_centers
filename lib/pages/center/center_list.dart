import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:radiology_centers/pages/center/send_result.dart';

import '../models/bookings_model.dart';

class CenterList extends StatefulWidget {
  String name;
  static const routeName = '/centerList';
  CenterList({required this.name});

  @override
  State<CenterList> createState() => _CenterListState();
}

class _CenterListState extends State<CenterList> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Booking> bookingList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchBookings();
  }

  @override
  void fetchBookings() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("bookings");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Booking p = Booking.fromJson(event.snapshot.value);
      bookingList.add(p);
      keyslist.add(event.snapshot.key.toString());
      setState(() {});
    });
  }

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
                    title: Text('قائمة الحجوزات')),
                body: Column(
                  children: [
                    Expanded(
                      flex: 8,
                      child: ListView.builder(
                        itemCount: bookingList.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (widget.name == bookingList[index].centerName) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            right: 15,
                                            left: 15,
                                            bottom: 10),
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  'الاسم :  ${bookingList[index].userName.toString()}',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'Cairo'),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  'رقم الهاتف: ${bookingList[index].userPhone.toString()}',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'Cairo'),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  'نوع الأشعة: ${bookingList[index].type.toString()}',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'Cairo'),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  'التاريخ : ${bookingList[index].date.toString()}',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'Cairo'),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 40,
                                                    vertical: 10),
                                                child: InkWell(
                                                  onTap: () async {
                                                    
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return SendResult(
                                                        userName:
                                                            '${bookingList[index].userName.toString()}',
                                                        userUid:
                                                            '${bookingList[index].userUid.toString()}',
                                                        date: '${bookingList[index].date.toString()}',
                                                        centerName: '${bookingList[index].centerName.toString()}',
                                                        
                                                      );
                                                    }));
                                                    
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 50.0,
                                                    width: size.width * 0.5,
                                                    decoration: new BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(80.0),
                                                        gradient:
                                                            new LinearGradient(
                                                                colors: [
                                                              Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  136,
                                                                  34),
                                                              Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  177,
                                                                  41)
                                                            ])),
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    child: Text(
                                                      "ارسال نتائج الأشعة",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              super.widget));
                                                  base
                                                      .child(bookingList[index]
                                                          .id
                                                          .toString())
                                                      .remove();
                                                },
                                                child: Icon(Icons.delete,
                                                    color: Color.fromARGB(
                                                        255, 122, 122, 122)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Text('');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )),
    );
  }
}
