import 'dart:convert';
import 'package:fullter_main_app/src/app_utility/flavor/app_config.dart';
import 'package:fullter_main_app/src/helper/local_constant.dart';
import 'package:fullter_main_app/src/helper/shared_preferencesFile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'main_common.dart';

Future<void> main() async {
  // if you are using await in main function then add this line
  WidgetsFlutterBinding.ensureInitialized();

  Provider.debugCheckInvalidValueType = null;

  // Restrict for portrait mode onl3
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  AppConfig(
      flavor: Environment.development,
      appDisplayName: "Flutter App",
      appInternalId: 1);

  bool isLoggedIn = await sharedPreferencesFile.readBool(isUSerLoggedInC);
  Locale mLocale = isLoggedIn ? await lang() : null;
  //await Future.delayed(const Duration(seconds: 60));
  runApp(MainCommon(isLoggedIn: isLoggedIn, locale: mLocale));
}

Future<Locale> lang() async {
  Locale mLocale = Locale('ko', 'KR');
  String languageCode, countryCode;
  String value = await SharedPreferencesFile().readStr(languageCodeC);
  if (value != null && value != '') {
    Map localDetails = json.decode(value);
    languageCode = localDetails["languageCode"];
    countryCode = localDetails["countryCode"];
    if (languageCode != null &&
        languageCode != '' &&
        countryCode != null &&
        countryCode != '') {
      mLocale = Locale(languageCode, countryCode);
    } else {
      mLocale = null;
    }
  }
  //First Time User
  else {
    mLocale = null;
    // SharedPreferencesFile().saveStr(selectedLanguageC, selectedLanguageKoreanC);
    SharedPreferencesFile().saveBool(isFirstTimeC, true);
  }
  return mLocale;
}

