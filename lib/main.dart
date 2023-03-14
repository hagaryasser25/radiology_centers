import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:radiology_centers/pages/admin/add_center.dart';
import 'package:radiology_centers/pages/admin/admin_centers.dart';
import 'package:radiology_centers/pages/admin/admin_home.dart';
import 'package:radiology_centers/pages/auth/admin_login.dart';
import 'package:radiology_centers/pages/auth/login.dart';
import 'package:radiology_centers/pages/auth/login_page.dart';
import 'package:radiology_centers/pages/auth/signup.dart';
import 'package:radiology_centers/pages/center/center_home.dart';
import 'package:radiology_centers/pages/user/user_home.dart';

import 'pages/auth/center_login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? LoginScreen()
          : FirebaseAuth.instance.currentUser!.email == 'admin@gmail.com'
              ? const AdminHome()
              : FirebaseAuth.instance.currentUser!.displayName == 'مركز'
                  ? const CenterHome()
                  : UserHome(),
      routes: {
        SignUp.routeName: (ctx) => SignUp(),
        AdminHome.routeName: (ctx) => AdminHome(),
        AdminCenters.routeName: (ctx) => AdminCenters(),
        AddCenter.routeName: (ctx) => AddCenter(),
        CenterHome.routeName: (ctx) => CenterHome(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        AdminLogin.routeName: (ctx) => AdminLogin(),
        CenterLogin.routeName: (ctx) => CenterLogin(),
        UserHome.routeName: (ctx) => UserHome(),
      },
    );
  }
}
