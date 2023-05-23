import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rohitashwa_project/pages/user_onboarding/onboarding_screens/enter_otp.dart';
import 'package:rohitashwa_project/pages/user_onboarding/onboarding_screens/enter_phone_number_screen.dart';
import 'package:rohitashwa_project/pages/user_onboarding/onboarding_screens/user_details.dart';
import 'package:rohitashwa_project/pages/user_onboarding/user_onboarding_viewModel.dart';


class UserOnboardingView extends StatefulWidget {
  const UserOnboardingView({Key? key}) : super(key: key);

  @override
  State<UserOnboardingView> createState() => _UserOnboardingViewState();
}

class _UserOnboardingViewState extends State<UserOnboardingView> {

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<UserOnboardingViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child:SingleChildScrollView(
        child: Column(
            //mainAxisSize: MainAxisSize.max,
            children: [
              imageCoverGrad("https://www.cnet.com/a/img/resize/69256d2623afcbaa911f08edc45fb2d3f6a8e172/hub/2023/02/03/afedd3ee-671d-4189-bf39-4f312248fb27/gettyimages-1042132904.jpg?auto=webp&fit=crop&height=675&width=1200"),

             SizedBox(
               height: 300.h,
               child: PageView(
                 physics: const NeverScrollableScrollPhysics(),
                 controller: viewModel.pageController,
                 onPageChanged: viewModel.onPageViewChange,
                 children: _buildQuestions(),
               ),
             ),
              SizedBox(
                height: 13.h,
              ),
            ],
          ),
      ),
      ),
    );
  }

  List<Widget> _buildQuestions() {
    return [
 //LanguagePreference( controller: _pageController,),
      PhoneNumberScreen(),
      OtpScreen(),
      const UserDetails(),
    ];
  }





  Widget imageCoverGrad( coverUrl) {
    return ShaderMask(
      shaderCallback: (rect) {
        return const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.black, Colors.transparent],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.darken,
      child: Image.network(
        coverUrl,
        height: 400.h,
        fit: BoxFit.cover,
      ),
    );
  }
}
