import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rohitashwa_project/bloc/auth/auth_bloc.dart';
import 'package:rohitashwa_project/bloc/auth/auth_event.dart';
import 'package:rohitashwa_project/bloc/auth/auth_state.dart';
import 'package:rohitashwa_project/bloc/network/network_event.dart';
import 'package:rohitashwa_project/bloc/network/network_bloc.dart';
import 'package:rohitashwa_project/bloc/network/network_state.dart';
import 'package:rohitashwa_project/pages/user_profile/user_profile_view.dart';
import 'package:rohitashwa_project/pages/user_profile/user_profile_viewModel.dart';
import 'package:rohitashwa_project/pages/user_onboarding/user_onboarding.dart';
import 'package:rohitashwa_project/pages/user_onboarding/user_onboarding_viewModel.dart';
import 'package:rohitashwa_project/services/observers/bloc_observers.dart';
import 'package:rohitashwa_project/services/observers/route_observers.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final routeObserver = MyRouteObserver();
  final blocObserver = MyBlocObserver();

  // Register the custom BLoC observer
  Bloc.observer = blocObserver;
  runApp(
    MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserOnboardingViewModel()),
        ChangeNotifierProvider(create: (_) => UserProfileViewModel()),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(AuthObserve()),
        ),
        BlocProvider(
          create: (context) => NetworkBloc()..add(NetworkObserve()),
        ),
        // Add more BlocProviders as needed
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return  App(routeObserver: routeObserver,);
          }),
    ),
  );
}

class App extends StatelessWidget {
  final MyRouteObserver routeObserver;
  const App({Key? key, required this.routeObserver}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [routeObserver],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is AuthSuccess) {
          return BlocBuilder<NetworkBloc, NetworkState>(
            builder: (context, state) {
              if (state is NetworkFailure) {
                return const Text("No Internet Connection,authenticated");
              } else if (state is NetworkSuccess) {
                return const UserProfileView();
              } else {
                return const CircularProgressIndicator();
              }
            },
          );
        } else {
          return BlocBuilder<NetworkBloc, NetworkState>(
            builder: (context, state) {
              if (state is NetworkFailure) {
                return const Text("No Internet Connection, non authenticated");
              } else if (state is NetworkSuccess) {
                return const UserOnboardingView();
              } else {
                return const CircularProgressIndicator();
              }
            },
          );
        }
      }),
    );
  }
}


