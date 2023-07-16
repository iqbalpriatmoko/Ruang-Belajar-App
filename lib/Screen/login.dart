import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:ruang_belajar/screen/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300, // Adjust the width as needed
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                controller: _email,
              ),
            ),
            SizedBox(height: 16), // Add some spacing between the input fields
            SizedBox(
              width: 300, // Adjust the width as needed
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: Icon(Icons.remove_red_eye), // Eye icon
                ),
                controller: _password,
              ),
            ),
            SizedBox(height: 16), // Add some spacing between the input fields
            SizedBox(
              width: 300, // Adjust the width as needed
              child: ElevatedButton(
                onPressed: () {
                  if (_email.text == "user" && _password.text == "userpass") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Email / Password salah')));
                  }
                },
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
