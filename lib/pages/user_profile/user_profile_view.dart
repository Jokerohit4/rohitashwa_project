import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rohitashwa_project/pages/user_profile/user_profile_viewModel.dart';
import 'package:rohitashwa_project/utils/style.dart';
import 'package:rohitashwa_project/widgets/helping_widgets.dart';
import 'package:rohitashwa_project/widgets/tile.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UserProfileViewModel>();
    viewModel.fetchUser();
    return  viewModel.user != null
    ?  Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20.0.h),
            child: const Text(
              "User Profile",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0.h),
            child: CircleAvatar(
              radius: 40.h,
              child: Image.network(
                'https://png.pngtree.com/png-vector/20220709/ourmid/pngtree-businessman-user-avatar-wearing-suit-with-red-tie-png-image_5809521.png',
                width: 50.h,
              ),
            ),
          ),
          Text(
            "Rohitashwa Singh",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.h,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              score("242", "Orders Placed"),
              //  Container(
              //   height: 50.h,
              //   width: 5.w,
              //   color: Colors.black,
              // ),
              score("2435", "Credits Scored"),
              // Container(
              //   height: 50.h,
              //   width: 5.w,
              //   color: Colors.black,
              // ),
              score("45678", "World Ranking"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HelpingWidgets.boxes(ColorsValue.lightRed, Colors.red.shade200,
              ()=> viewModel.onTapLikes(), Icons.favorite, "Likes"),
              HelpingWidgets.boxes(ColorsValue.primary, Colors.green.shade200,
                      ()=> viewModel.onTapLikes(), Icons.credit_card, "Payments"),
              HelpingWidgets.boxes(Colors.black, Colors.black12,
                      ()=>  viewModel.onTapLikes(), Icons.settings, "Settings"),
            ],
          ),
   Tile(title: viewModel.user?['ph'], subtitle: 'Phone number', isEditable:false, onTap:()=>viewModel.onTapEditPhoneNumber(),),
         Tile(title: viewModel.user?['lang pref'] == 'en_IN' ? 'English' : 'Hindi',  subtitle: 'Preferred Language', isEditable:false, onTap:()=>viewModel.onTapEditPrefLang(),),
          //Tile(title: '8765438902', subtitle: 'Phone number', isEditable:false, onTap:viewModel.onTapLikes(),),
        logOutButton(()=>viewModel.onTapLogOut(context)),
        ],
      ),
    ))
        :const CircularProgressIndicator();
  }

  Widget logOutButton(onTap){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 310.w,
        height: 80,
        margin: EdgeInsets.symmetric(vertical: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.blue,
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
        child: const Center(child: Text("Log Out",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white
        ),)),
      ),
    );
  }

  Widget score(String score, String label) {
    return SizedBox(
      height: 80.h,
      width: 100.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            score,
            style: TextStyle(
              fontSize: 30.h,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 10.h,
            ),
          ),
        ],
      ),
    );
  }
}
