import 'package:flutter/material.dart';
import 'package:zoom_clone/screens/home.dart';
import 'package:zoom_clone/services/auth.dart';
import 'package:zoom_clone/utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    AuthMethods _authmethods = AuthMethods();
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            ' Start or Join the Meeting',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Image.asset('assets/images/onboarding.jpg'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              child: const Text('Google Sign In'),
              style: ElevatedButton.styleFrom(
                  primary: buttonColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: buttonColor),
                  )),
              onPressed: () async {
                final res = await _authmethods.signInWihtGoogle(context);
                if (res) {
                  Navigator.of(context).pushNamed(Home.id);
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}
