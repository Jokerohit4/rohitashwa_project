import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rohitashwa_project/pages/user_onboarding/user_onboarding.dart';
import 'package:rohitashwa_project/pages/user_onboarding/user_onboarding_viewModel.dart';

import 'firebase_firestore.dart';



class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FireStore();
  final _storage = const FlutterSecureStorage();
  int _resendToken = 0;
  String _verificationId = '';

  get resendToken => _resendToken;
  get verificationId => _verificationId;
  Future<void> signInUser(otpControllerText, pageController) async {
    try{
      print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      //print(UserData.verificationId);
//      await verifyOTP(otpControllerText, UserData.verificationId);
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
          verificationId: '',
          //UserData.verificationId,
          smsCode: otpControllerText))
          .then((user) {
        print('qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq');
        //_storage.write(
         //   key: 'user_ID_Cattle_Guru', value: UserData.verificationId);
        FirebaseFirestore.instance.collection("agents").doc(user.user!.uid).set({
          "userId": user.user!.uid,
          //"phoneNumber": UserData.phoneNumber,
        }).whenComplete(() {
          pageController.nextPage(
              duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        });
      });
    }
    catch(e){
      print('llllllllllllllllllll : $e');
    }
  }

  checkUserLogIn() async {
    String? storageRetrievedLocale = await _storage.read(
      key: 'user_ID_Cattle_Guru',
    );
    debugPrint(storageRetrievedLocale.toString());
  }

  Future<void> resendOTP(String phoneNumber,
      Function(String, int?) codeSent) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 120),
      forceResendingToken: _resendToken,
      verificationCompleted: (PhoneAuthCredential credential) {
        signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          debugPrint('The provided phone number is not valid.');
        }
      },
      codeSent: codeSent,
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> signInWithCredential(PhoneAuthCredential credential) async {
    try {
      await _auth.signInWithCredential(credential);
      debugPrint('User signed in successfully.');
    } catch (e) {
      debugPrint('Error signing in with credential: ${e.toString()}');
    }
  }

  Future<void> verifyOTP(String otp,pageController) async {
    print(_verificationId);
    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: otp);
      await _auth.signInWithCredential(credential).whenComplete(() =>  pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn));
      // await _signInWithPhoneNumber(credential);
    } catch (e) {
      debugPrint('Error verifying OTP: $e');
    }
  }

  Future<void> _signInWithPhoneNumber(
      AuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
      await _auth.signInWithCredential(phoneAuthCredential);
      if (authCredential.user != null) {
        Fluttertoast.showToast(msg: 'Phone number verified');
        // Navigate to home screen on successful login
      }
    } catch (e) {
      debugPrint('Error signing in with phone number: $e');
    }
  }

  Future<void> verifyPhoneNumber(String phoneNumber, _verificationId) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 120),
        verificationCompleted: (AuthCredential phoneAuthCredential) async {
          await _signInWithPhoneNumber(phoneAuthCredential);
        },
        verificationFailed: (FirebaseAuthException authException) {
          debugPrint(
              'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
        },
        codeSent: (String verificationId, [int? forceResendingToken]) async {
          Fluttertoast.showToast(msg: 'Verification code sent to $phoneNumber');
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      debugPrint('Error verifying phone number: $e');
    }
  }

  Future<bool> sendOTP({required String phone,context}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) async {
      //  debugPrint('bbbbbbbbbbbbbbbbbbbbbbb');
        debugPrint('Verification Id is : $verificationId');
 _verificationId = verificationId;
 _resendToken = resendToken!;
      },
      timeout: const Duration(seconds: 120),
      codeAutoRetrievalTimeout: (String verificationId) {
      },
    );
   // debugPrint("_verificationId: ${UserData.verificationId}");
    return true;
  }

  Future<void> logOutUser() async {
    await FirebaseAuth.instance
        .signOut();
  }

}