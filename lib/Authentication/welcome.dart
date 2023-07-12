import 'package:apna_khata/Authentication/SignIn_screen.dart';
import 'package:apna_khata/Authentication/SignUp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class WelomeScreen extends StatelessWidget {
  const WelomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(60),
                bottomLeft: Radius.circular(60),
              ),
              color: Color(0xffC700FF),
            ),
            height: MediaQuery.of(context).size.height / 2,
            width: double.infinity,
            child: const Padding(
              padding: EdgeInsets.fromLTRB(45, 50, 50, 0),
              child: Image(
                image: AssetImage('assets/Apnakhata_Welcomescreen.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Own Dream Order',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 60,
            ),
            child: Text(
              'Set Your Delivery Location Quick Deliver to your Doorstep Order Online From Your Favourite Store Set Your Delivery Location Quick Deliver to your Doorstep.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 65,
          ),
          ToggleSwitch(
            borderColor: [Colors.blueGrey],
            minHeight: 60,
            minWidth: 130.0,
            cornerRadius: 16.0,
            activeBgColors: const [
              //[(Color(0xFFFFE259)), (Color(0xFFFFA751))],
              //[(Color(0xFFFFE259)), (Color(0xFFFFA751))]
              [Color(0xffC700FF)],
              [Color(0xffC700FF)],
            ],
            activeFgColor: Colors.white,
            inactiveBgColor: Colors.white,
            inactiveFgColor: Colors.black,
            initialLabelIndex: 0,
            totalSwitches: 2,
            labels: const ['Sign in', 'Sign up'],
            radiusStyle: true,
            onToggle: (index) {
              if (index == 0) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SignInscreen()));
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SignUpScreen()));
              }
            },
          ),
        ],
      ),
    );
  }
}
