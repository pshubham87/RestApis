import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restapi/LogIn.dart';
import 'package:restapi/validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: usernameController,
                decoration: const InputDecoration(
                  hintText: "name",
                  border: OutlineInputBorder(),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: nameValidator,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: emailValidator,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: "password",
                  border: OutlineInputBorder(),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: passValidator,
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Signup(context);
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text('sign up'),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MyHomePage();
                            },
                          ),
                          (route) => false,
                        );
                      },
                      child: Text("Login Here here")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Signup(context) async {
    const url = 'https://devicorpoprod.herokuapp.com/api/users';
    var response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "name": usernameController.text,
          "email": emailController.text,
          "password": passwordController.text,
        }),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Accept": "application/json",
        });
    print(response.statusCode);
    if (response.statusCode == 200 && (_formKey.currentState!.validate())) {
      var registerArr = json.decode(response.body);
      print(registerArr['token']);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', registerArr['token']);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Colors.green,
          content: Text("Successfule Created Account")));
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    } else if (response.statusCode == 400 &&
        (_formKey.currentState!.validate())) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
          content: Text("Account Already Existed, please Login")));
    }
  }
}
