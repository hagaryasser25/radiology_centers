import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:radiology_centers/pages/admin/admin_centers.dart';

import '../auth/login.dart';
import '../models/users_model.dart';
import 'center_list.dart';

class CenterHome extends StatefulWidget {
  static const routeName = '/centerHome';
  const CenterHome({super.key});

  @override
  State<CenterHome> createState() => _CenterHomeState();
}

class _CenterHomeState extends State<CenterHome> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  late Users currentUser;

  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await base.get();
    setState(() {
      currentUser = Users.fromSnapshot(snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xFF2661FA),
            title: Center(child: Text('الصفحة الرئيسسة'))),
        body: Column(
          children: [
            Image.asset('assets/images/center.jfif'),
            Text(
              'الخدمات المتاحة',
              style: TextStyle(fontSize: 27, color: HexColor('#32486d')),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Row(children: [
              SizedBox(width: size.width * 0.04),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CenterList(
                      name: '${currentUser.fullName}',
                    );
                  }));
                },
                child: Container(
                  child: Container(
                    width: size.width * 0.45,
                    height: size.height * 0.30,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xfff1665f),
                          Color(0xFF2661FA),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: Center(
                      child: Text('قائمة الحجوزات',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.04,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('تأكيد'),
                          content: Text('هل انت متأكد من تسجيل الخروج'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.pushNamed(
                                    context, LoginScreen.routeName);
                              },
                              child: Text('نعم'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('لا'),
                            ),
                          ],
                        );
                      });
                },
                child: Container(
                  child: Container(
                    width: size.width * 0.45,
                    height: size.height * 0.30,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xfff1665f),
                          Color(0xFF2661FA),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: Center(
                      child: Text('تسجيل الخروج',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                ),
              )
            ])
          ],
        ),
      ),
    );
  }
}
