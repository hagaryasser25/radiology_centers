import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:radiology_centers/pages/admin/admin_centers.dart';
import 'package:radiology_centers/pages/auth/login.dart';

class AdminHome extends StatefulWidget {
  static const routeName = '/adminHome';
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
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
                  Navigator.pushNamed(context, AdminCenters.routeName);
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
                      child: Text('أضافة مركز',
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
