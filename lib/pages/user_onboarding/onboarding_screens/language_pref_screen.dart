// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class LanguagePreference extends StatelessWidget {
//   LanguagePreference({Key? key, required this.controller}) : super(key: key);
//   final PageController controller;
//
//   @override
//   Widget build(BuildContext context) {
//    //  int? val = HelpingMethods.val;
//  //   LangController langController = LangController(val);
//     void onTapEnglish({required BuildContext context}) {
//       MyApp.of(context).changeLocale(locale: LOCALES.english);
//       setLocale('en');
//       HelpingMethods.val = 1;
//       //  FirebaseAnalytics.instance.logEvent(
//       //   name: 'selected_english_click',
//       //  parameters: {
//       //    'button_name': 'selected_english_click',
//       //    'screen_name': 'settings_screen',
//       //  },
//       //);
//     }
//
//     void onTapHindi({required BuildContext context}) {
//       MyApp.of(context).changeLocale(locale: LOCALES.hindi);
//       setLocale('hi');
//       HelpingMethods.val = 2;
//       //   FirebaseAnalytics.instance.logEvent(
//       //  name: 'selected_hindi_click',
//       //  parameters: {
//       //  'button_name': 'selected_hindi_click',
//       //  'screen_name': 'settings_screen',
//       // },
//       //);
//     }
//
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           AppLocalizations.of(context)!.select_app_language,
//           style: const TextStyle(
//               color: Colors.black, fontSize: 23, fontWeight: FontWeight.w500),
//         ),
//         SizedBox(
//           height: 20.h,
//         ),
//         ThemeButton(
//           title: "Hindi",
//           // color: ColorsValue.,
//
//           onPress: () {
//             UserData.languagePref = "hi";
//             onTapHindi(context: context);
//             controller.nextPage(
//                 duration: const Duration(milliseconds: 300),
//                 curve: Curves.easeIn);
//           },
//         ),
//         SizedBox(
//           height: 20.h,
//         ),
//         ThemeButton(
//           title: "English",
//           //color: Colors.orange,
//           onPress: () {
//                  onTapEnglish(context: context);
//             UserData.languagePref = "en";
//             controller.nextPage(
//                 duration: const Duration(milliseconds: 300),
//                 curve: Curves.easeIn);
//           },
//         ),
//       ],
//     );
//   }
// }
