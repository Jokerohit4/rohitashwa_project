import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:rohitashwa_project/pages/user_onboarding/user_onboarding_viewModel.dart';
import 'package:rohitashwa_project/widgets/theme_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {






  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<UserOnboardingViewModel>(context);
    print(viewModel.phoneNumberController.text);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
        key: viewModel.otpFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Enter Phone Number',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: 365.w,
              height: 70.w,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Pinput(
                  controller: viewModel.otpController,
                  length: 6,
                  onChanged: (String pin) {
                    debugPrint(pin);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            ThemeButton(
              title: 'verify otp',
              onPress: () => viewModel.onPressVerifyOTP(context),
            ),
          ],
        ),
      ),
    );
  }
}
