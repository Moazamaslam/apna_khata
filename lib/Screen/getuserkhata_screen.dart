import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserAmountScreen extends StatefulWidget {
  final String id;

  UserAmountScreen({
    required this.id,
  });

  @override
  State<UserAmountScreen> createState() => _UserAmountScreenState();
}

class _UserAmountScreenState extends State<UserAmountScreen> {
  final userKhataCollectionRef = FirebaseFirestore.instance.collection('Khata');
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String accountName = "";
  bool isDebit = true;
  DateTime selectdate = DateTime.now();
  List<String> months = [
    "January",
    "Fabuary",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  Future<void> _selecteddate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectdate,
      firstDate: DateTime(2020, 12),
      lastDate: DateTime(2100, 01),
    );
    if (picked != null && picked != selectdate) {
      setState(() {
        selectdate = picked;
      });
    }
  }

  void addUser() async {
    try {
      final User? user = auth.currentUser;
      var id = userKhataCollectionRef.doc().id;

      userKhataCollectionRef.doc(id).set({
        'amount': accountName,
        'uid': user!.uid,
        'id': id,
        'user_id': widget.id,
        'is_debit': isDebit,
        'created_date': selectdate.year.toString() +
            "/" +
            selectdate.month.toString() +
            "/" +
            selectdate.day.toString(),
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
                    'Add Amount',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 32.0, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 80.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10.0,
                      ),
                      Text("Debit"),
                      Radio(
                        value: true,
                        groupValue: isDebit,
                        onChanged: (bool? value) {
                          print("debit" + value.toString());
                          setState(() {
                            if (value != null) isDebit = value;
                          });
                        },
                      ),
                      Text("Credit"),
                      Radio(
                        value: true,
                        groupValue: !isDebit,
                        onChanged: (bool? value) {
                          print("credit" + value.toString());

                          setState(() {
                            if (value != null) isDebit = !value;
                          });
                        },
                      ),
                    ],
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
                            maxLength: 10,
                            validator: (amount) {
                              if (amount!.isEmpty || amount == null) {
                                return 'required';
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Amount',
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
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _selecteddate(context);
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: FaIcon(
                            FontAwesomeIcons.calendar,
                            size: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 18.0,
                        ),
                        Text(
                          '${selectdate.day} ${months[selectdate.month - 1]} ${selectdate.year}',
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
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
