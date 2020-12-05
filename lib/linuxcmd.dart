import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Lcmd extends StatefulWidget {
  @override
  _LcmdState createState() => _LcmdState();
}

class _LcmdState extends State<Lcmd> {
  var data;
  var cmd;
  var fieldclear =
      TextEditingController(); //to clear the text field when the cmd is sent
  var firebaseconnect =
      FirebaseFirestore.instance; //initialize firestore services
  var authentication =
      FirebaseAuth.instance; //initialize authentication services

  /*launchurl() async {
    const url =
        "https://console.firebase.google.com/u/1/project/t3linuxintegration/firestore/data~2FConsoleData~2FwclEhiSuQJSZCQODdgNi";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'error setting up connection ${url}';
    }
  }*/

  firebasedata(cmd) async {
    var useremail = authentication.currentUser.email;
    var firebaseconnect = FirebaseFirestore.instance;
    var url = "http://192.168.43.248/cgi-bin/t3intgn.py?cmd=$cmd";
    var response = await http.get(url);

    setState(() {
      data = response.body;
    });

    print(data);

    await firebaseconnect.collection('ConsoleData').add({
      "Admin": useremail, //add the username in firestore database
      '$cmd': "$data" //add command and its output in the database
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('TERMINAL'),
          backgroundColor: Colors.black,
        ),
        body: Stack(
          children: <Widget>[
            Image(
              image: AssetImage('assets\images\bgimage3.jpg'),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Text(
                'ENTER YOUR COMMAND',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 80, 20, 20),
              child: TextField(
                controller: fieldclear,
                onChanged: (value) {
                  cmd = value;
                },
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                cursorWidth: 12.0,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  prefixIcon: Text(
                    "[root@localhost ~]#",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  prefixIconConstraints:
                      BoxConstraints(minWidth: 10, minHeight: 0),
                  //prefixText: '[root@localhost ~]#',
                  prefixStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white10,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white10,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.fromLTRB(10, 150, 10, 10),
              child: Material(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(10),
                child: MaterialButton(
                  onPressed: () {
                    firebasedata(cmd);
                    fieldclear.clear();
                    //launchurl();
                  },
                  child: Text(
                    'RUN',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 200, 10, 10),
              //color: Colors.white.withOpacity(0.3),
              color: Colors.grey.withOpacity(0.3),
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Text(
                    data ?? " ", //checks the null operator
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}