

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rohitashwa_project/utils/style.dart';

class HelpingWidgets{




  static Widget boxes(Color boxColor, Color shadowColor,onTap,IconData icon,String label){
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.0.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 90.h,
          width: 90.w,
          decoration: BoxDecoration(
            color: boxColor,
            border: Border(),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,color: Colors.white,),
              Padding(
                padding: EdgeInsets.only(top: 8.0.h),
                child: Text(label,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 10.h),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}