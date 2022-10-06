import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restapi/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var loading = false;
  loginUser(context) async {
    loading = true;
    const url = 'https://devicorpoprod.herokuapp.com/api/auth';
    var response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "email": usernameController.text,
          "password": passwordController.text,
        }),
        headers: <String, String>{
          "Content-Type": "application/json",
        });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var loginArr = json.decode(response.body);
      print(loginArr['token']);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', loginArr['token']);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else if (response.statusCode == 400) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
          content: Text("Entered Wrong Email Or Password.")));
    }
  }
}
