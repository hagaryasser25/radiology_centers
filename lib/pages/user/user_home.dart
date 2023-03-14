import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:radiology_centers/pages/auth/login.dart';
import 'package:radiology_centers/pages/user/ray_result.dart';
import 'package:radiology_centers/pages/user/update_profile.dart';
import 'package:radiology_centers/pages/user/user_bookings.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/center_model.dart';
import '../models/users_model.dart';
import 'center_details.dart';

class UserHome extends StatefulWidget {
  static const routeName = '/userHome';
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Centers> centersList = [];
  List<String> keyslist = [];
  late Users currentUser;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchCenters();
  }

  @override
  void fetchCenters() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("centers");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Centers p = Centers.fromJson(event.snapshot.value);
      centersList.add(p);
      keyslist.add(event.snapshot.key.toString());
      print(keyslist);
      setState(() {});
    });
  }

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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF2661FA),
            title: Center(child: Text('مراكز الاشعة')),
          ),
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: 200.h,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF2661FA),
                          Color(0xfff1665f),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            backgroundImage:
                                AssetImage('assets/images/logo.jpg'),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Material(
                    color: Colors.transparent,
                    child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () {
                            
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return UpdateProfile(
                                email: currentUser.email,
                                password: currentUser.password,
                                name: '${currentUser.fullName}',
                                phoneNumber: '${currentUser.phoneNumber}',
                                uid: FirebaseAuth.instance.currentUser!.uid,
                              );
                            }));
                            
                          },
                          title: Text('الملف الشخصى'),
                          leading: Icon(Icons.person),
                        ))),
                Material(
                    color: Colors.transparent,
                    child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return UserBookings(
                                name: '${currentUser.fullName}',
                              );
                            }));
                          },
                          title: Text('حجوزاتى'),
                          leading: Icon(Icons.book),
                        ))),
                Material(
                    color: Colors.transparent,
                    child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return RayResult(
                                name: '${currentUser.fullName}',
                              );
                            }));
                          },
                          title: Text('نتائج الأشعة'),
                          leading: Icon(Icons.document_scanner),
                        ))),
                Divider(
                  thickness: 0.8,
                  color: Colors.grey,
                ),
                Material(
                    color: Colors.transparent,
                    child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('تأكيد'),
                                    content:
                                        Text('هل انت متأكد من تسجيل الخروج'),
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
                          title: Text('تسجيل الخروج'),
                          leading: Icon(Icons.exit_to_app_rounded),
                        )))
              ],
            ),
          ),
          body: Column(
            children: [
              Image.asset('assets/images/center.jfif'),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w, left: 20.w),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        child: StaggeredGridView.countBuilder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(
                            top: 25.h,
                            bottom: 15.h,
                          ),
                          crossAxisCount: 6,
                          itemCount: centersList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return CenterDetails(
                                    name: '${centersList[index].name}',
                                    address: '${centersList[index].address}',
                                    imageUrl: '${centersList[index].imageUrl}',
                                    phoneNumber:
                                        '${centersList[index].phoneNumber}',
                                    workTime: '${centersList[index].workTime}',
                                    userName: '${currentUser.fullName}',
                                    userUid: '${currentUser.uid}',
                                    userPhone: '${currentUser.phoneNumber}',
                                  );
                                }));
                              },
                              child: Container(
                                child: Container(
                                  width: 50.w,
                                  height: 20.h,
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
                                    child: FittedBox(
                                      child: Text('${centersList[index].name}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          staggeredTileBuilder: (int index) =>
                              new StaggeredTile.count(3, index.isEven ? 3 : 3),
                          mainAxisSpacing: 18.0,
                          crossAxisSpacing: 10.0.w,
                        ),
                      )
                    ],
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
