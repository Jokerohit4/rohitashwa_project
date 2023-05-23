import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _storage = FlutterSecureStorage();

class LOCALES {
  static const Locale _english = Locale('en', '');
  static const Locale _hindi = Locale('hi', '');
  static final Locale _platform = Locale(Platform.localeName, '');

  static Locale get english {
    return _english;
  }

  static Locale get hindi {
    return _hindi;
  }

  static Locale get platform {
    return _platform;
  }
}

Future<Locale> setLocale(String langCode) async {
  await _storage.write(key: 'language_code_Cattle_Guru', value: langCode);
  if (kDebugMode) {
    print(_storage.read(key: 'language_code_Cattle_Guru').toString());
  }
  return locale(langCode);
}

Locale locale(String languageCode) {
  Locale _temp;
  if (languageCode == 'hi') {
    _temp = const Locale('hi');
  } else if (languageCode == 'en') {
    _temp = const Locale('en');
  }
  else
  {
_temp = const Locale('en');
  } 
  return _temp;
}


Future deleteAlll() async {
  await _storage.deleteAll();
}

Future<Locale> getLocale() async {
  String? storageRetrievedLocale =
      await _storage.read(key: 'language_code_Cattle_Guru');
  if (kDebugMode) {
    print(storageRetrievedLocale.toString());
  }
  if (storageRetrievedLocale != null) {
   // HelpingMethods.isFirstTimeUser = false;
    return locale(storageRetrievedLocale.toString());
  } else {
    return locale(Platform.localeName.substring(0, 2));
  }
}
