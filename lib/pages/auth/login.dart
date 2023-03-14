import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:ndialog/ndialog.dart';
import 'package:radiology_centers/pages/auth/admin_login.dart';
import 'package:radiology_centers/pages/auth/signup.dart';

import '../components/background.dart';
import '../user/user_home.dart';
import 'center_login.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/loginPage';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var passwordController = TextEditingController();

  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Background(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "تسجيل الدخول",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA),
                      fontSize: 30),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: "البريد الألكترونى"),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: "كلمة المرور"),
                  obscureText: true,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: InkWell(
                  onTap: () async {
                    var email = emailController.text.trim();
                    var password = passwordController.text.trim();

                    if (email.isEmpty || password.isEmpty) {
                      MotionToast(
                              primaryColor: Colors.blue,
                              width: 300,
                              height: 50,
                              position: MotionToastPosition.center,
                              description: Text("please fill all fields"))
                          .show(context);

                      return;
                    }


                    ProgressDialog progressDialog = ProgressDialog(context,
                        title: Text('Logging In'),
                        message: Text('Please Wait'));
                    progressDialog.show();

                    try {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      UserCredential userCredential =
                          await auth.signInWithEmailAndPassword(
                              email: email, password: password);

                      if (userCredential.user != null) {
                        progressDialog.dismiss();
                        Navigator.pushNamed(context, UserHome.routeName);
                      }
                    } on FirebaseAuthException catch (e) {
                      progressDialog.dismiss();
                      if (e.code == 'user-not-found') {
                        MotionToast(
                                primaryColor: Colors.blue,
                                width: 300,
                                height: 50,
                                position: MotionToastPosition.center,
                                description: Text("user not found"))
                            .show(context);

                        return;
                      } else if (e.code == 'wrong-password') {
                        MotionToast(
                                primaryColor: Colors.blue,
                                width: 300,
                                height: 50,
                                position: MotionToastPosition.center,
                                description: Text("wrong email or password"))
                            .show(context);

                        return;
                      }
                    } catch (e) {
                      MotionToast(
                              primaryColor: Colors.blue,
                              width: 300,
                              height: 50,
                              position: MotionToastPosition.center,
                              description: Text("something went wrong"))
                          .show(context);

                      progressDialog.dismiss();
                    }
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
                      "تسجيل الدخول",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: GestureDetector(
                      onTap: () => {
                         Navigator.pushNamed(context, AdminLogin.routeName)
                      },
                      child: Text(
                        "تسجيل الدخول كمدخل بيانات",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2661FA)),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => {
                       Navigator.pushNamed(context, CenterLogin.routeName)
                      },
                      child: Text(
                        "تسجيل الدخول كمركز",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2661FA)),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: GestureDetector(
                  onTap: () => {Navigator.pushNamed(context, SignUp.routeName)},
                  child: Text(
                    "انشاء حساب",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
