import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  // final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    child: Expanded(
                      child: Image.asset(
                        "assets/Apnakhata_Welcomescreen.png",
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Forgot Password',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              const Padding(padding: EdgeInsets.only(top: 20.0)),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",

                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val?.length == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      action: SnackBarAction(
                        label: "ok",
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                      backgroundColor: Colors.white,
                      content: Text(
                        'Please Enter Your Email',
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                    ));
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: emailController.text)
                      .then((value) => Navigator.of(context).pop());
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 5, right: 5, top: 30),
                  alignment: Alignment.center,
                  height: 55,
                  //  padding: EdgeInsets.only(left: 70, right: 70,),
                  decoration: BoxDecoration(
                    color: Color(0xffC700FF),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 0,
                      )
                    ],
                  ),
                  child: const Text(
                    'Reset Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
