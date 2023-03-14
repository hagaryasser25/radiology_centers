import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:radiology_centers/pages/center/send_result.dart';
import 'package:radiology_centers/pages/models/results_model.dart';

import '../models/bookings_model.dart';

class RayResult extends StatefulWidget {
  String name;
  static const routeName = '/userBookings';
  RayResult({required this.name});

  @override
  State<RayResult> createState() => _RayResultState();
}

class _RayResultState extends State<RayResult> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Results> resultList = [];
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
    base = database.reference().child("results");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Results p = Results.fromJson(event.snapshot.value);
      resultList.add(p);
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
                    title: Text('النتائج')),
                body: Column(
                  children: [
                    Expanded(
                      flex: 8,
                      child: ListView.builder(
                        itemCount: resultList.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (widget.name == resultList[index].userName) {
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
                                              Image.network('${resultList[index].imageUrl.toString()}',
                                              height:200.h),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  'اسم المركز :  ${resultList[index].centerName.toString()}',
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
                                                  'التاريخ : ${resultList[index].date.toString()}',
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
                                                  'نتيجة الأشعة : ${resultList[index].result.toString()}',
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
                                                  'سبب المرض: ${resultList[index].reason.toString()}',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'Cairo'),
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
                                                      .child(resultList[index]
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