import 'package:apna_khata/Accounting_screen/DB_helper.dart';
import 'package:apna_khata/Screen/home_page.dart';
import 'package:flutter/material.dart';

class AddNamescreen extends StatefulWidget {
  const AddNamescreen({Key? key}) : super(key: key);

  @override
  State<AddNamescreen> createState() => _AddNamescreenState();
}

class _AddNamescreenState extends State<AddNamescreen> {
  DBhelper dBhelper = DBhelper();
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 140.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
                  child: Image.asset(
                    "assets/moneybag.png",
                    width: 72.0,
                    height: 72.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 120.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'What should we call our business !',
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(
              height: 28.0,
            ),
            Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 18.0),
                  child: TextField(
                    decoration: InputDecoration(
                        // hintText: "Name",
                        label: Text("Business name")),
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                )),
            SizedBox(
              height: 32.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: 50.0,
                width: double.maxFinite,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color(0xffC700FF)),
                    onPressed: () {
                      if (name.isNotEmpty) {
                        //add to database
                        dBhelper.addName(name);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MyHomePage()));
                      } else {
                        //show some error
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          action: SnackBarAction(
                            label: "ok",
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            },
                          ),
                          backgroundColor: Colors.white,
                          content: Text(
                            'Please Enter the name',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black),
                          ),
                        ));
                      }
                    },
                    child: Text("Next")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
