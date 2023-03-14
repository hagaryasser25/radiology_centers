import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:radiology_centers/pages/admin/add_center.dart';
import 'package:radiology_centers/pages/models/center_model.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class AdminCenters extends StatefulWidget {
  static const routeName = '/adminCenters';
  const AdminCenters({super.key});

  @override
  State<AdminCenters> createState() => _AdminCentersState();
}

class _AdminCentersState extends State<AdminCenters> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Centers> centersList = [];
  List<String> keyslist = [];

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
      if (mounted) {
        setState(() {});
      }
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
            title: Align(
                alignment: Alignment.topRight,
                child: TextButton.icon(
                  // Your icon here
                  label: Text(
                    'أضافة مركز',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  icon: Align(
                      child: Icon(
                    Icons.add,
                    color: Colors.white,
                  )), // Your text here
                  onPressed: () {
                    Navigator.pushNamed(context, AddCenter.routeName);
                  },
                )),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Container(
                child: Expanded(
                  flex: 8,
                  child: ListView.builder(
                      itemCount: centersList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(right: 20.w, left: 20.w),
                                  child: Container(
                                    width: double.infinity,
                                    child: Card(
                                      child: Column(
                                        children: [
                                          Image.network(
                                            '${centersList[index].imageUrl}',
                                            height: 200.h,
                                          ),
                                          Text(
                                            'اسم المركز : ${centersList[index].name}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Cairo',
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            'البريد الألكترونى: ${centersList[index].email}',
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            'كلمة المرور : ${centersList[index].password}',
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            'رقم الهاتف : ${centersList[index].phoneNumber}',
                                            style: TextStyle(
                                              fontSize: 19,
                                              color: Colors.black,
                                            ),
                                          ),
                                           Text(
                                            'العنوان : ${centersList[index].address}',
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                            ),
                                          ),
                                            Text(
                                            'مواعيد العمل : ${centersList[index].workTime}',
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
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
                                              FirebaseDatabase.instance
                                                  .reference()
                                                  .child('centers')
                                                  .child(
                                                      '${centersList[index].id}')
                                                  .remove();
                                            },
                                            child: Icon(Icons.delete,
                                                color: Color.fromARGB(
                                                    255, 122, 122, 122)),
                                          )
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
