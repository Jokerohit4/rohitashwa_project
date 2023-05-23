

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rohitashwa_project/bloc/auth/auth_bloc.dart';
import 'package:rohitashwa_project/bloc/auth/auth_event.dart';

class AuthHelper {

  static void observeAuth() {
    if(FirebaseAuth.instance.currentUser != null)
    {
      AuthBloc().add(AuthNotify(isAuthenticated: true));
    }
    else {
      AuthBloc().add(AuthNotify());
    }
  }
}