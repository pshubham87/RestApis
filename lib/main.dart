// import 'package:api/LogIn.dart';
import 'package:flutter/material.dart';
import 'package:restapi/HomeScreen.dart';
import 'package:restapi/LogIn.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  dynamic token = SharedPreferences.getInstance();

  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // token != '' ? : const HomeScreen()
        home: const MyHomePage());
  }
}
