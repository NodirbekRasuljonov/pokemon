import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon/constants/color_const.dart';

class InfoPage extends StatelessWidget {
  int index;
  InfoPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorConst.kWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColorConst.kbackgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text("Pokemon Info",style: TextStyle(color: AppColorConst.kWhiteColor),),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
        child: Column(
          children: [
            Container(
              height: 350.h,
              width: 400.w,
              color: Colors.amber,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0.h,
                    left: 0.w,
                    right: 0.w,
                    child: Container(
                    height: 200.h,
                    width: 400.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: AppColorConst.kbackgroundColor,
                    ),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
