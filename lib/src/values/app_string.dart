import 'package:flutter/material.dart';

class AppString {
  static BuildContext context;

  AppString(context1) {
    if (context1 != null) {
      context = context1;
      try {
//        var appLocalizations = AppLocalizations.of(context);
       // logoutConfirmation = appLocalizations.translate('logout');
      } catch (e) {
        print(e);
      }
    } else {}
  }

  String appName = 'Freebs';
  String tryAgain = 'Something went wrong please try again';
  //Button text
  String buttonSave = "Save";
  String buttonCancel = "Cancel";
  String buttonApply = "Apply";
  String buttonConfirm = "Confirm";

  //Alert message
  String logoutConfirmation = "Are you sure you want to logout";
  String deletePostMessage = "Are you sure to delete this post?";
  String deleteGroupChannelMessage = "Are you sure to delete this Group Channel?";
  String leftGroupMessage = "Are you sure to left this group?";
  String noInternetConnection = "No internet connection available. Please check your network!";
  String noText = "No";
  String yesText = "Yes";

  //error messages
  String passwordNotBlank = 'Please enter the password.';
  String passwordLength = '*Minimum password length is 6 charactors';
  String screenTermsAndConditions = "Terms and conditions";

  //Login screen strings
  String contactText = "If you have problems to login, please get in contact at ";
  String acceptTermsAndConditions = 'Check here to indicate that you have read and agree to the "';
  String termsAndConditions = 'terms of the main flutter app';

  //Contact email id
  String contactEmail = "dexbytes@gmail.com";

  String emailNotBlank = 'Please enter your number';
  String validEmail = 'Please enter a valid mobile number.';
  //confirmation message
  String confirmationMessage =
      "Are you sure you want to delete this notification?";
  String confirmationLogoutMessage =
      "Are you sure you want to logout from the app?";
  String confirmationExitMessage =
      "Are you sure you want to exit from the app?";
  String confirmationDeletePostMessage =
      "Are you sure you want to delete this post?";
  String confirmationDeleteGroupMessage =
      "Are you sure you want to delete this group?";
  String confirmationLeftGroupMessage =
      "Are you sure you want to leave this group?";
  //appLocalizations.translate('basicInfo');
}
