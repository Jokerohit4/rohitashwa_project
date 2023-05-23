




import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rohitashwa_project/pages/user_onboarding/user_onboarding.dart';
import 'package:rohitashwa_project/services/firebase_firestore.dart';
import 'package:rohitashwa_project/services/firebaseauth_services.dart';

class UserProfileViewModel with ChangeNotifier{


  final _auth = FirebaseAuthServices();
  final _fireStore = FireStore();
   TextEditingController phoneNumberController = TextEditingController();//unused
  Map<String, dynamic>? _user;
  bool isPhoneNumberEditable = false;//unused
  bool isPreferredLangEditable = false;//unused

  get user => _user;


  //used for fill-ups
  onTapLikes(){
  }

  //on tapping the logout button
  onTapLogOut(context){
   _auth.logOutUser().whenComplete(() =>   Navigator.push(context,
       MaterialPageRoute(builder: (context) => const UserOnboardingView())));
  }

  //unused
  onTapEditPrefLang(){
    isPreferredLangEditable = true;
  }

  //unused
  onTapEditPhoneNumber(){
    isPhoneNumberEditable = true;
    phoneNumberController.text = _user!['ph'];
  }

  //to fetch current user details
  fetchUser() async {
    _user = await _fireStore.fetchUser(FirebaseAuth.instance.currentUser?.uid);
    notifyListeners();
  }
}