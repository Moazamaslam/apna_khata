import 'package:apna_khata/Screen/PDF%20Generator.dart';
import 'package:apna_khata/Screen/filehandlingAPI.dart';
import 'package:apna_khata/Screen/getuserkhata_screen.dart';
import 'package:apna_khata/Screen/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UserKhataScreen extends StatefulWidget {
  final String id;
  final String name;
  UserKhataScreen({required this.id, required this.name});
  @override
  State<UserKhataScreen> createState() => _UserKhataScreenState();
}

class _UserKhataScreenState extends State<UserKhataScreen> {
  double totalamount = 0;
  late double credit;
  late double debit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            tooltip: 'Expense',
            onPressed: () async {
              final pdfFile = await PdfInvoiceApi.generate();

              // opening the pdf file
              FileHandleApi.openFile(pdfFile);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UserAmountScreen(id: widget.id)));
        },
        backgroundColor: Colors.purple,
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Consumer<StatProvider>(
            builder: (cxt, provider, child) {
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
                  child: Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.arrowCircleUp,
                        size: 28.0,
                        color: Colors.red[700],
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        children: [
                          Text(
                            'Debit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 18.0,
                      ),
                      Column(
                        children: [
                          Text(
                            'Total Balance',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 22.0, color: Colors.white),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            'Rs' + provider.total.toString(),
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 28.0, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      FaIcon(
                        FontAwesomeIcons.arrowCircleDown,
                        size: 28.0,
                        color: Colors.green[700],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Credit',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Khata')
                  .where('user_id', isEqualTo: widget.id)
                  .snapshots(),
              builder: (context, snapshot) {
                List<Map<String, dynamic>> list = [];
                if (snapshot.data != null && snapshot.data!.docs != null) {
                  for (QueryDocumentSnapshot q in snapshot.data!.docs) {
                    Map<String, dynamic> map = q.data() as Map<String, dynamic>;
                    list.add(map);
                  }
                }

                double total = getTotal(list);
                // print("Total =>" + total.toString());
                //print("sdgs");
                totalamount = total;
                WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                  Provider.of<StatProvider>(context, listen: false)
                      .setTotal(totalamount);
                });

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
                      onTap: () {},
                      child: Container(
                          margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.all(10.0),
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xf0000FF
                                //     data['is_debit'] ? 0xf0000FF : 0xffC700FF
                                ),
                            borderRadius: BorderRadius.circular(
                              18.0,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text('RS '),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(data['amount']),
                                ],
                              ),
                              SizedBox(
                                width: 42.0,
                              ),
                              Text(data["created_date"].toString()),
                              SizedBox(
                                width: 42.0,
                              ),
                              data['is_debit']
                                  ? FaIcon(
                                      FontAwesomeIcons.arrowCircleUp,
                                      size: 28.0,
                                      color: Colors.red[700],
                                    )
                                  : FaIcon(
                                      FontAwesomeIcons.arrowCircleDown,
                                      size: 28.0,
                                      color: Colors.green[700],
                                    ),
                            ],
                          )),
                    );
                  }).toList(),
                );
              }),
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
    // print(second['amount'].toString() + " => " + total.toString());
    // if (first == null) {
    if (second['is_debit']) {
      //debit += double.parse(second['amount'].toString());
      total -= double.parse(second['amount'].toString());
    } else {
      // credit = double.parse(second['amount'].toString());
      total += double.parse(second['amount'].toString());
    }
    // } else {
    //   if (first!['is_debit'] && second['is_debit']) {
    //     debit += double.parse(second['amount'].toString());
    //     total = total - debit;
    //   } else if (first['is_debit'] && second!['is_debit']) {
    //     credit += double.parse(second['amount'].toString());
    //     total = total + credit;
    //   } else {
    //     total = double.parse(second['amount'].toString()) + total;
    //   }
    // }
    return total;
  }
}
