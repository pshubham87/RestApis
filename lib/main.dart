// import 'package:api/LogIn.dart';
import 'package:flutter/material.dart';
import 'package:restapi/HomeScreen.dart';
import 'package:restapi/LogIn.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  var profiletoken = pref.getString('token') ?? null;
  runApp(MaterialApp(
    home: profiletoken == null ? const MyHomePage() : const HomeScreen(),
  ));
}

// class MyApp extends StatelessWidget {



//   MyApp({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: token != '' ? const MyHomePage() : const HomeScreen(),
//     );
//   }
// }
