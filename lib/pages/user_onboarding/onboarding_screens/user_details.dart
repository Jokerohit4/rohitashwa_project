import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rohitashwa_project/pages/user_onboarding/user_onboarding_viewModel.dart';
import 'package:rohitashwa_project/widgets/theme_button.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {




  @override
  Widget build(BuildContext context) {
    final viewModel = UserOnboardingViewModel();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
        key: viewModel.detailsFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Please enter Name',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 30.h,),
            SizedBox(
              width: 320.w,
              child: TextFormField(
                controller: viewModel.firstNameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Enter Name',
                  border: const OutlineInputBorder(),
                ),
                validator: viewModel.validateName,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            ThemeButton(
              title: 'Continue',
              onPress: () => viewModel.onPressContinue(context),
            ),
          ],
        ),
      ),
    );
  }
}
