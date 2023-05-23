import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Tile extends StatefulWidget {
  const Tile({Key? key, required this.title, required this.subtitle, this.onTap, required this.isEditable}) : super(key: key);
final String title;
final String subtitle;
final onTap;
final bool isEditable;
  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 310.w,
        height: 80,
        margin: EdgeInsets.symmetric(vertical: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child:widget.isEditable
        ? const SizedBox(
          width: 400,
          height: 100,
          // child: Row(
          //   children: [
          //     SizedBox(
          //       width: 300,
          //       height: 100,
          //       child: TextField(
          //        controller: viewModel.phoneNumberController,
          //       ),
          //     ),
          //     TextButton(onPressed: (){viewModel.isPhoneNumberEditable = false;}, child: Text('Submit'))
          //   ],
        //  ),
        )
        :Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(widget.subtitle),
              ],
            ),
            const Spacer(),
            const Icon(Icons.edit),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
