
import 'package:flutter/material.dart';
import 'package:Mashair/app_louncher.dart';

import 'app-configs.dart';
import 'consts/views/assets.dart';

void main() async {
  await AppConfigration()
    ..FirebaseInit(MyConfigAssets.firebaseConfig)
    ..setAppLocal('ar')
    ..RouteInit()
  .. getaikey();
  runApp(const AppLouncher());
}