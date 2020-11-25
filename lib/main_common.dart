import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fullter_main_app/src/all_file_import/app_providers_files_link.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/app_utility/app_localizations.dart';
import 'package:fullter_main_app/src/app_utility/flavor/app_config.dart';
import 'package:fullter_main_app/src/config/routes.dart';
import 'package:fullter_main_app/src/helper/local_constant.dart';
import 'package:fullter_main_app/src/helper/shared_preferencesFile.dart';
import 'package:fullter_main_app/src/state/appState.dart';
import 'package:fullter_main_app/src/state/theme_changer.dart';
import 'package:provider/provider.dart';
import 'src/all_file_import/app_screens_files_link.dart';
import 'src/all_file_import/app_values_files_link.dart';

class MainCommon extends StatefulWidget {
  final bool isLoggedIn;
  final Locale locale;
  MainCommon({Key key, this.isLoggedIn, this.locale}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.changeLanguage(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MainCommon> {
  bool isCheckedLang = false;
  bool isInit = false;

  Locale _locale = Locale('en', 'US');
  // Locale _locale = Locale('hi', 'IN');
  Locale _localeDefult = Locale('en', 'US');

  var supportedLocales1 = [
    Locale('en', 'US'),
    Locale('hi', 'IN')
  ];

  @override
  void initState() {
    getLanguage();
    super.initState();
  }

  getLanguage() async {
    String languageCode, countryCode;
    SharedPreferencesFile().readStr(languageCodeC).then((value) {
      if (value != null && value != '') {
        Map localDetails = json.decode(value);
        languageCode = localDetails["languageCode"];
        countryCode = localDetails["countryCode"];
        if (languageCode != null &&
            languageCode != '' &&
            countryCode != null &&
            countryCode != '') {
          setState(() {
            _locale = Locale(languageCode, countryCode);
          });
        } else {
          setState(() {
            _locale = _localeDefult;
          });
        }
      }else{
        _locale = _localeDefult;
        SharedPreferencesFile().saveStr(selectedLanguageC, selectedLanguageEnglishC);
        changeLanguage(_locale);
      }
    });
  }

  getLanguage1() async {
    SharedPreferencesFile().readBool(isFirstTimeC).then((value) {
      if (value != null && value) {
        _locale = _localeDefult;
        SharedPreferencesFile().saveStr(selectedLanguageC, selectedLanguageEnglishC);
        changeLanguage(_locale);
        SharedPreferencesFile().saveBool(isFirstTimeC, false);

        /* _locale =  ui.window.locale;
        if(_locale.languageCode!=null &&  _locale.languageCode == "ko"){
          SharedPreferencesFile().saveStr(selectedLanguageC,selectedLanguageKoreanC);
        }
        else if(_locale.languageCode!=null &&  _locale.languageCode == "en"){
          SharedPreferencesFile().saveStr(selectedLanguageC,selectedLanguageEnglishC);
        }
        else{
          _locale = _localeDefult;
          SharedPreferencesFile().saveStr(selectedLanguageC,selectedLanguageKoreanC);
        }
        changeLanguage(_locale);*/
      } else {
        String languageCode, countryCode;
        SharedPreferencesFile().readStr(languageCodeC).then((value) {
          if (value != null && value != '') {
            Map localDetails = json.decode(value);
            languageCode = localDetails["languageCode"];
            countryCode = localDetails["countryCode"];
            if (languageCode != null &&
                languageCode != '' &&
                countryCode != null &&
                countryCode != '') {
              setState(() {
                _locale = Locale(languageCode, countryCode);
              });
            } else {
              setState(() {
                _locale = _localeDefult;
              });
            }
          }
        });
        //projectUtil.printP("main","language code2: $languageCode $countryCode");
      }
    });
  }

  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
      String languageCode = locale.languageCode;
      String countryCode = locale.countryCode;
      var localDetails = {
        "languageCode": languageCode,
        "countryCode": countryCode
      };
      String localDetailsStr = jsonEncode(localDetails);
      sharedPreferencesFile.saveStr(languageCodeC, localDetailsStr);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.locale != null && !isInit) {
      setState(() {
        isInit = true;
        _locale = widget.locale;
      });
    }

    if (Platform.isAndroid) {
      try {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light)); //top bar icons));
      } catch (e) {
        print(e);
      }
    }
    else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      )  /*Or Brightness.dark*/);
    }
    var config = AppConfig.instance;
    ConstantC.isProduction =
    config.environment == Environment.production ? true : false;

    return MultiProvider(
        providers: [
           ChangeNotifierProvider<NotificationState>(create: (_) => NotificationState(),),
          ChangeNotifierProvider<AppState>(
            create: (_) => AppState(),
          ), //Manage app status
          ChangeNotifierProvider<ThemeChanger>(
            create: (_) => ThemeChanger(),
          ), //Manage app status
          Provider<AppStyle>(
            create: (context) => AppStyle(),
          ),
          Provider<AppDimens>(
            create: (context) => AppDimens(),
          ),
          Provider<AppColors>(
            create: (context) => AppColors(),
          ),
          Provider<AppFonts>(
            create: (context) => AppFonts(),
          ),
          Provider<AppString>(
            create: (context) => AppString(context),
          ),
          /*Provider<UserAuthState>(
            create: (context) => UserAuthState(),*/
          //),
        ],
        child:  MaterialApp(
          debugShowCheckedModeBanner: ConstantC.isProduction,
          title: '${config.appDisplayName}',
          // List all of the app's supported locales here
          supportedLocales: supportedLocales1,
          locale: _locale,
          //theme: themeSwitch.getTheme(),
          theme: ThemeData(
            // This is the theme of your application.
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            brightness: Brightness.light,
            primarySwatch: AppColors().appThemeColor,
            accentColor: AppColors().appThemeColor,
            /*    primarySwatch: AppColors().appThemeColor,
                accentColor: AppColors().appThemeColor,
                primaryColor: AppColors().appThemeColor,*/
            textSelectionHandleColor: AppColors().appTransColor[700],
          ),
          // These delegates make sure that the localization data for the proper language is loaded
          localizationsDelegates: [
            // THIS CLASS WILL BE ADDED LATER
            // A class which loads the translations from JSON files
            AppLocalizations.delegate,
            // Built-in localization of basic text for Material widgets
            GlobalMaterialLocalizations.delegate,
            // Built-in localization for text direction LTR/RTL
            GlobalWidgetsLocalizations.delegate,
          ],
          // Returns a locale which will be used by the app
          localeResolutionCallback: (locale, supportedLocales) {
            // If the locale of the device is not supported, use the first one
            // from the list (English, in this case).
            return _locale != null ? _locale : supportedLocales.first;
          },
          //Routes File
          routes: Routes.route(),
          onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
          onUnknownRoute: (settings) => Routes.onUnknownRoute(settings),
          //initialRoute: "SplashPage",
          // home: anotherLandingScreen(),
          home: (widget.isLoggedIn!=null && widget.isLoggedIn) ? mainLandingScreen() : anotherLandingScreen()/*FutureBuilder(
            future: sharedPreferencesFile.readBool(isUSerLoggedInC),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData) {
                var value = snapshot.data;
                return value ? mainLandingScreen() : anotherLandingScreen();
              }
              return Container(); // noop, this builder is called again when the future completes
            },
          )*/,

        ));
  }
  mainLandingScreen() {
    return SplashPage(isLoggedIn: widget.isLoggedIn);
  }
  anotherLandingScreen() {
    return SplashPage(isLoggedIn: widget.isLoggedIn);
  }
}
