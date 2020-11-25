import 'package:flutter/material.dart';
enum Environment {
  local,
  development,
  acceptance,
  production
}
class AppConfig {
  final Environment environment;
 // final AppValues values;
  final int appInternalId;
  final String appDisplayName;

  static AppConfig _instance;

  factory AppConfig({
    @required Environment flavor,
    @required int appInternalId,@required String appDisplayName}) {
    _instance ??= AppConfig._internal(flavor, appInternalId,appDisplayName);
    return _instance;
  }

  AppConfig._internal(this.environment, this.appInternalId,this.appDisplayName);
  static AppConfig get instance { return _instance;}

}