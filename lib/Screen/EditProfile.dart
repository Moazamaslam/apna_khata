import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Edit Profile',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    child: Expanded(
                      child: Image.asset(
                        "assets/images/FrutaLogo.jpeg",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Name",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val?.length == 0) {
                    return "Name cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20.0)),
              TextFormField(
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
                    return "Name cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20.0)),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Password",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val?.length == 0) {
                    return "Name cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20.0)),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val?.length == 0) {
                    return "Name cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20.0)),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val?.length == 0) {
                    return "Name cannot be empty";
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
                height: 26,
              ),
              GestureDetector(
                // onTap: () {
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => HomeScreen()));
                // },
                child: Container(
                  margin: const EdgeInsets.only(left: 5, right: 5, top: 30),
                  alignment: Alignment.center,
                  height: 55,
                  //  padding: EdgeInsets.only(left: 70, right: 70,),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [(Color(0xFFFFE259)), (Color(0xFFFFA751))],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 0,
                      )
                    ],
                  ),
                  child: const Text(
                    'Save',
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
