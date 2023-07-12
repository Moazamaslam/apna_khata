import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UsersDataScreen extends StatefulWidget {
  UsersDataScreen({Key? key}) : super(key: key);

  @override
  State<UsersDataScreen> createState() => _UsersDataScreenState();
}

class _UsersDataScreenState extends State<UsersDataScreen> {
  final userCollectionRef = FirebaseFirestore.instance.collection('Users');
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String accountName = "";

  void addUser() async {
    try {
      final User? user = auth.currentUser;
      var id = userCollectionRef.doc().id;

      userCollectionRef.doc(id).set({
        'name': accountName,
        'uid': user!.uid,
        'id': id,
      }).then((value) {
        Navigator.of(context).pop();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(60),
                    bottomLeft: Radius.circular(60),
                  ),
                  color: Color(0xffC700FF),
                ),
                height: MediaQuery.of(context).size.height / 3,
                width: double.infinity,
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(45, 50, 50, 0),
                  child: Image(
                    image: AssetImage('assets/Apnakhata_Welcomescreen.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 32.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Add User',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 32.0, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 80.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          padding: EdgeInsets.all(12.0),
                          child: FaIcon(
                            FontAwesomeIcons.user,
                            size: 24.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 18.0),
                        Expanded(
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            maxLength: 10,
                            validator: (name) {
                              if (name!.isEmpty || name == null) {
                                return 'required';
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Name',
                              // border: InputBorder.none,
                            ),
                            onChanged: (val) {
                              try {
                                //  amount = int.parse(val);
                                accountName = val;
                              } catch (e) {
                                //you can create any toast and any action
                              }
                            },
                            style: TextStyle(fontSize: 24.0),
                            // inputFormatters: [
                            // FilteringTextInputFormatter.singleLineFormatter
                            // ],
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 36.0,
                  ),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xffC700FF)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          addUser();
                        }
                      },
                      child: Text('ADD'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
