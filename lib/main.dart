import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spoton/views/addProjectScreen.dart';
import 'package:spoton/views/loginScreen.dart';
import 'package:spoton/views/otpScreen.dart';
import 'package:spoton/views/welcomeScreen.dart';
import 'package:spoton/views/projectDashboardScreen.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const welcomeScreen(),
    );
  }
}
