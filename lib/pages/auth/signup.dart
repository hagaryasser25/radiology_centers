import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:ndialog/ndialog.dart';

import '../components/background.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/signupPage';
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var nameController = TextEditingController();
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
                  "انشاء حساب",
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
                  controller: nameController,
                  decoration: InputDecoration(labelText: "الأسم"),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(labelText: "رقم الهاتف"),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: "البريد الالكترونى"),
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
              SizedBox(height: size.height * 0.05),
              InkWell(
                onTap: () async {
                  var name = nameController.text.trim();
                  var phoneNumber = phoneNumberController.text.trim();
                  var email = emailController.text.trim();
                  var password = passwordController.text.trim();

                  if (name.isEmpty ||
                      email.isEmpty ||
                      password.isEmpty ||
                      phoneNumber.isEmpty) {
                    MotionToast(
                            primaryColor: Colors.blue,
                            width: 300,
                            height: 50,
                            position: MotionToastPosition.center,
                            description: Text("please fill all fields"))
                        .show(context);

                    return;
                  }

                  if (password.length < 6) {
                    // show error toast
                    MotionToast(
                            primaryColor: Colors.blue,
                            width: 300,
                            height: 50,
                            position: MotionToastPosition.center,
                            description: Text(
                                "Weak Password, at least 6 characters are required"))
                        .show(context);

                    return;
                  }

                  ProgressDialog progressDialog = ProgressDialog(context,
                      title: Text('Signing Up'), message: Text('Please Wait'));
                  progressDialog.show();

                  try {
                    FirebaseAuth auth = FirebaseAuth.instance;

                    UserCredential userCredential =
                        await auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    User? user = userCredential.user;

                    if (userCredential.user != null) {
                      DatabaseReference userRef =
                          FirebaseDatabase.instance.reference().child('users');

                      String uid = userCredential.user!.uid;
                      int dt = DateTime.now().millisecondsSinceEpoch;

                      await userRef.child(uid).set({
                        'name': name,
                        'email': email,
                        'password': password,
                        'uid': uid,
                        'dt': dt,
                        'phoneNumber': phoneNumber,
                      });

                      Navigator.canPop(context) ? Navigator.pop(context) : null;
                    } else {
                      MotionToast(
                              primaryColor: Colors.blue,
                              width: 300,
                              height: 50,
                              position: MotionToastPosition.center,
                              description: Text("failed"))
                          .show(context);
                    }
                    progressDialog.dismiss();
                  } on FirebaseAuthException catch (e) {
                    progressDialog.dismiss();
                    if (e.code == 'email-already-in-use') {
                      MotionToast(
                              primaryColor: Colors.blue,
                              width: 300,
                              height: 50,
                              position: MotionToastPosition.center,
                              description: Text("email is already exist"))
                          .show(context);
                    } else if (e.code == 'weak-password') {
                      MotionToast(
                              primaryColor: Colors.blue,
                              width: 300,
                              height: 50,
                              position: MotionToastPosition.center,
                              description: Text("password is weak"))
                          .show(context);
                    }
                  } catch (e) {
                    progressDialog.dismiss();
                    MotionToast(
                            primaryColor: Colors.blue,
                            width: 300,
                            height: 50,
                            position: MotionToastPosition.center,
                            description: Text("something went wrong"))
                        .show(context);
                  }
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
                      "انشاء حساب",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
