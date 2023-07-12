import 'package:apna_khata/Authentication/SignIn_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  void registration(BuildContext context) async {
    // if (_formKey.currentState.validate()) {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
        // email: email, password: password,
      );
      if (user != null) {
        // checkUserAlreadyExists(user.user!);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInscreen()),
        );
        // .then((value) => dispose());
        // showToast('Login Successfully');
      }
    } catch (exception) {
      print(exception.toString());
      // showToast(e.toString());
      // showToast('Invalid Password');
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
                const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
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
                      'Sign_Up',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
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
                  validator: (Email) {
                    if (Email!.isEmpty || Email == null) {
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
                  obscureText: true,
                  obscuringCharacter: '*',
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (pass) {
                    if (pass!.isEmpty || pass == null) {
                      return 'Password cannot be empty';
                    }
                  },
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                TextFormField(
                  obscureText: true,
                  obscuringCharacter: '*',
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (pass) {
                    if (pass!.isEmpty || pass == null) {
                      return 'Password cannot be empty';
                    } else if (pass != passwordController) {
                      return 'Confirm password must be same as Password';
                    }
                    // if (val?.length == 0) {
                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //     action: SnackBarAction(
                    //       label: "ok",
                    //       onPressed: () {
                    //         ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    //       },
                    //     ),
                    //     backgroundColor: Colors.white,
                    //     content: Text(
                    //       'Please Retype the Password',
                    //       style: TextStyle(fontSize: 18.0, color: Colors.black),
                    //     ),
                    //   ));
                    // } else if (passwordController != confirmPasswordController) {
                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //     action: SnackBarAction(
                    //       label: "ok",
                    //       onPressed: () {
                    //         ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    //       },
                    //     ),
                    //     backgroundColor: Colors.white,
                    //     content: Text(
                    //       'Confirm password Does not match with password',
                    //       style: TextStyle(fontSize: 18.0, color: Colors.black),
                    //     ),
                    //   ));
                    // } else {
                    //   return null;
                    // }
                  },
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      registration(context);
                    }
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
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    SizedBox(
                      width: 4,
                    ),
                    InkWell(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            color: Color(0xffC700FF),
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInscreen()));
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
