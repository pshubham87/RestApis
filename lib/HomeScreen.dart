// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:restapi/LogIn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var loading = false;
  var data;
  void initState() {
    super.initState();
    profile();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: loading == true
            ? Center(child: CircularProgressIndicator())
            : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "name : ${data['name']}",
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                    Text(
                      "email  : ${data['email']}",
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: MaterialButton(
                    color: Colors.blue,
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.clear();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const MyHomePage();
                          },
                        ),
                        (route) => false,
                      );
                    },
                    child: Text('Logout'),
                  ),
                )
              ]),
      ),
    );
  }

  void profile() async {
    setState(() {
      loading = true;
    });

    SharedPreferences pref = await SharedPreferences.getInstance();
    var profiletoken = pref.getString('token');
    print(profiletoken);
    const url = 'https://devicorpoprod.herokuapp.com/api/auth';
    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "x-auth-token": profiletoken!
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var dataa = json.decode(response.body);

      setState(() {
        data = dataa;
      });
      print(data);
      setState(() {
        loading = false;
      });
    }
  }
}
