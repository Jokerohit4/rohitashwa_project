import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rohitashwa_project/utils/style.dart';

class ThemeButton extends StatelessWidget {
  final String title;
  final Function? onPress;
  final Color? color;
 const ThemeButton({
    super.key,
    required this.title,
    this.onPress,
  this.color = ColorsValue.primary});


  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPress as void Function()?,
        child: Material(
          elevation: 15,
          borderRadius: BorderRadius.circular(10),
          color: color,
          child: SizedBox(
     width: 350.w,
            height: 50.h,
            child: Center(
              child: Text(title,
                style:TextStyle(
                    color: ColorsValue.primaryTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
             ),
            ),
          ),
        ),
      ),
    );
  }
}
