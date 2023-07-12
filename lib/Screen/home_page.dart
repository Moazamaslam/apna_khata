import 'package:apna_khata/Accounting_screen/Homepage.dart';
import 'package:apna_khata/Authentication/SignIn_screen.dart';
import 'package:apna_khata/Screen/add_user.dart';
import 'package:apna_khata/Screen/userkhata_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late double totalamount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text('Apna Khata'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance_wallet),
            tooltip: 'personal Khata',
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Homepagescreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'LOGOUT',
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SignInscreen()));
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => UsersDataScreen()));
        },
        backgroundColor: Colors.purple,
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Khata').snapshots(),
              builder: (context, snapshot) {
                List<Map<String, dynamic>> list = [];
                double total = 0;
                if (snapshot.data != null && snapshot.data!.docs != null) {
                  for (QueryDocumentSnapshot q in snapshot.data!.docs) {
                    Map<String, dynamic> map = q.data() as Map<String, dynamic>;
                    list.add(map);
                  }
                }
                total = getTotal(list);
                return Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black, Colors.purpleAccent],
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(24.0),
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                    child: Column(
                      children: [
                        Text(
                          'Total Balance',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22.0, color: Colors.white),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          'Rs' + total.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 28.0, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              }),
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Users').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  children: snapshot.data!.docs.map((doc) {
                    Map<String, dynamic> data =
                        doc.data() as Map<String, dynamic>;
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UserKhataScreen(
                                  id: data['id'],
                                  name: data['name'],
                                )));
                      },
                      child: Container(
                          margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.all(10.0),
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Color(
                              0xffced4eb,
                            ),
                            borderRadius: BorderRadius.circular(
                              18.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.purple,
                                maxRadius: 24,
                                child: ClipOval(
                                  child: FaIcon(FontAwesomeIcons.user),
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                child: Text(data['name']),
                              ),
                              StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('Khata')
                                      .where('user_id',
                                          isEqualTo: data['id'].toString())
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    List<Map<String, dynamic>> list = [];
                                    double total = 0;
                                    if (snapshot.data != null &&
                                        snapshot.data!.docs != null) {
                                      for (QueryDocumentSnapshot q
                                          in snapshot.data!.docs) {
                                        Map<String, dynamic> map =
                                            q.data() as Map<String, dynamic>;
                                        list.add(map);
                                      }
                                    }
                                    total = getTotal(list);
                                    return Text("Rs :" + total.toString());
                                  }),
                            ],
                          )),
                    );
                  }).toList(),
                );
              })
        ],
      )),
    );
  }

  double getTotal(List<Map<String, dynamic>> list) {
    double total = 0;
    for (int index = 0; index < list.length; index++) {
      if (index == 0) {
        total = decide(null, list[index], total);
        print("If");
      } else {
        total = decide(list[index - 1], list[index], total);
        print("else");
      }
    }
    return total;
  }

  double decide(
      Map<String, dynamic>? first, Map<String, dynamic> second, double total) {
    print(second['amount'].toString() + " => " + total.toString());
    // if (first == null) {
    if (second['is_debit']) {
      total -= double.parse(second['amount'].toString());
    } else {
      total += double.parse(second['amount'].toString());
    }
    return total;
  }
}
