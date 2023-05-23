import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rohitashwa_project/models/user_model.dart';
import 'package:rohitashwa_project/pages/user_profile/user_profile_view.dart';
import 'package:rohitashwa_project/services/firebase_firestore.dart';
import 'package:rohitashwa_project/services/firebaseauth_services.dart';

class UserOnboardingViewModel with ChangeNotifier {
  final phoneNumberFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  final detailsFormKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final otpController = TextEditingController();
  final firestoreService = FireStore();
 final _firebaseAuthServices = FirebaseAuthServices();
  late UserModel _user;
  String code = '';

  final PageController pageController = PageController(
    initialPage: 0,
  );
 int _page =0;
  @override


  dynamic get page =>_page;

  UserModel get user => _user;


  //unused
  set user(UserModel value) {
    _user = value;
    firstNameController.text = _user.firstName;
    lastNameController.text = _user.lastName;
    emailController.text = _user.email;
    notifyListeners();
  }




  //adds user details to firestore
  Future<void> saveUser() async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    final langPref = Platform.localeName;
    final String firstName = firstNameController.text;
    final String lastName = lastNameController.text;
    final email = emailController.text;
    final user = UserModel(id: id,
        firstName: firstName,
        email: email,
        lastName: lastName,
        langPref: langPref);
    await firestoreService.addUser(user);
  }

  onPressSendOTP() {
    if (phoneNumberFormKey.currentState!.validate()) {
      _firebaseAuthServices.sendOTP(
        phone: "$code${phoneNumberController.text}",
      ).whenComplete(() =>
      pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn));
    }
  }

  //unused
  onPressResendOTP() {
    _firebaseAuthServices.resendOTP(
        "$code-${phoneNumberController.text}",
            (p0, p1) => null);
  }

  onPressVerifyOTP(context) async {
    final String phoneNumber = "$code-${phoneNumberController.text}";
    if (otpFormKey.currentState!.validate()) {
      debugPrint(_firebaseAuthServices.verificationId);
      try {
        await FirebaseAuth.instance
            .signInWithCredential(PhoneAuthProvider.credential(
            verificationId: _firebaseAuthServices.verificationId,
            smsCode: otpController.text))
            .then((user) {

              firestoreService.addUserPhoneNumber(phoneNumber);
          pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
        });
      } catch (e) {
        debugPrint(e.toString());
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('invalid otp'),
          duration: Duration(seconds: 3),
        ));
      }
    }
  }

  onPressContinue(context) {
    if (detailsFormKey.currentState!.validate()) {

      saveUser().whenComplete(() =>
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UserProfileView())));
    }
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty || value.length < 3) {
      'Enter name';
    }
    return null;
  }

  onPageViewChange(int value) {
     _page = value;
      notifyListeners();
  }
}