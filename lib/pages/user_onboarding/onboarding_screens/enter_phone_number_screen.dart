import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:rohitashwa_project/pages/user_onboarding/user_onboarding_viewModel.dart';
import 'package:rohitashwa_project/widgets/theme_button.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key,})
      : super(key: key);
  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {


  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<UserOnboardingViewModel>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
        key: viewModel.phoneNumberFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Please Enter phone number',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: 290.w,
              child: IntlPhoneField(
                controller: viewModel.phoneNumberController ,
                initialCountryCode: 'IN',
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                onChanged: (phone) {
                  debugPrint(phone.completeNumber);
                  debugPrint(phone.countryCode);
                  viewModel.code = phone.countryCode;
                },
                onCountryChanged: (country) {
                  debugPrint('Country changed to: ${country.name}');
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            ThemeButton(
              title: 'Send OTP',
              onPress: () => viewModel.onPressSendOTP(),
            ),
          ],
        ),
      ),
    );
  }
}
