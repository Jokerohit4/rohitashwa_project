



// Custom BLoC Observer
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // Handle state changes of your BLoCs
    debugPrint('BLoC state changed: $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    // Handle errors thrown by your BLoCs
    debugPrint('BLoC error: $error');
  }

// ... implement other necessary methods
}