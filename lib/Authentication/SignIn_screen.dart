import 'package:apna_khata/Accounting_screen/Add_name.dart';
import 'package:apna_khata/Accounting_screen/DB_helper.dart';
import 'package:apna_khata/Authentication/Forget-Password%20Screen.dart';
import 'package:apna_khata/Authentication/SignUp_screen.dart';
import 'package:apna_khata/Authentication/welcome.dart';
import 'package:apna_khata/Screen/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInscreen extends StatefulWidget {
  const SignInscreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInscreen> {
  final _formKey = GlobalKey<FormState>();
  DBhelper dBhelper = DBhelper();
  Future getSetting() async {
    String? name = await dBhelper.getName();
    if (name != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MyHomePage()));
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AddNamescreen()));
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  checkUserAlreadyExists(User user) async {
    final userData = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();
    if (userData == null || !userData.exists) {
      setState(() {
        getSetting();
      });
    } else {
      setState(() {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => WelomeScreen()));
      });
    }
  }

  void login(BuildContext context) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text,
        // email: email, password: password,
      );
      if (user != null) {
        checkUserAlreadyExists(user.user!);
      }
    } catch (exception) {
      print(exception.toString());
    }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 290,
                      width: 290,
                      child: Expanded(
                        child: Image.asset(
                          "assets/Apnakhata_Welcomescreen.png",
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 2.0,
                // ),
                Row(
                  children: [
                    Text(
                      'SignIn',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return 'Email cannot be empty';
                    }
                  },
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    labelText: "Password",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                  validator: (val) {
                    if (val?.length == 0) {
                      return "Password cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen()));
                      },
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      login(context);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 5, right: 5, top: 30),
                    alignment: Alignment.center,
                    height: 55,
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
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 46,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    SizedBox(
                      width: 4,
                    ),
                    InkWell(
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                            color: Color(0xffC700FF),
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
