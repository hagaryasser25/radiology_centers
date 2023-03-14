import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:radiology_centers/pages/models/rays_model.dart';
import 'package:radiology_centers/pages/user/book_ray.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class CenterRays extends StatefulWidget {
  String centerName;
  String userName;
  String userPhone;
  String userUid;
  CenterRays({
    required this.centerName,
    required this.userName,
    required this.userPhone,
    required this.userUid,
  });

  @override
  State<CenterRays> createState() => _CenterRaysState();
}

class _CenterRaysState extends State<CenterRays> {
  List<Rays> rays = [
    Rays(
      name: 'على الجمجمة',
      image: 'assets/images/brain.png',
      price: '100 جنيه',
    ),
    Rays(
      name: 'على العمود الفقرى',
      image: 'assets/images/backbone.png',
      price: '135 جنيه',
    ),
    Rays(
      name: 'على الكتف',
      image: 'assets/images/shoulder.png',
      price: '135 جنيه',
    ),
    Rays(
      name: 'على البطن',
      image: 'assets/images/stomach.png',
      price: '55 جنيه',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF2661FA),
              title: Text('اختر نوع الأشعة'),
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 15.h),
              child: SingleChildScrollView(
                child: Container(
                  child: StaggeredGridView.countBuilder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(
                      left: 15.w,
                      right: 15.w,
                    ),
                    crossAxisCount: 6,
                    itemCount: rays.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return BookRay(
                                centerName: '${widget.centerName}',
                                userName: '${widget.userName}',
                                userUid: '${widget.userUid}',
                                userPhone: '${widget.userPhone}',
                                type: '${rays[index].name}',
                              );
                            }));
                          },
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(right: 10.w, left: 10.w),
                              child: Center(
                                child: Column(children: [
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Image.asset('${rays[index].image}',
                                      width: 155.w, height: 155.h),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      '${rays[index].name}',
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      '${rays[index].price}',
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.count(3, index.isEven ? 3 : 3),
                    mainAxisSpacing: 50.0,
                    crossAxisSpacing: 5.0,
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
