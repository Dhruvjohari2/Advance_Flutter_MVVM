import 'package:advance_mvvm/app/di.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
  // runApp(EasyLocalization(child: MyApp(), supportedLocales: [], path: ''));
}
