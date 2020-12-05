import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Signin extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Signin> {
  var authentication = FirebaseAuth.instance;
  String email;
  var password;
  bool progbar = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset:
            false, //used to avoid the resize of the bg image while using keyboard
        appBar: AppBar(
          title: Text('REGISTRATION'),
          backgroundColor: Colors.black87,
        ),
        body: ModalProgressHUD(
          color: Colors.grey,
          inAsyncCall: progbar,
          child: Stack(
            children: <Widget>[
              Image(
                image: AssetImage('assets\images\bgimage3.jpg'),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 80,
                height: 80,
                alignment: Alignment.topCenter,
                margin: EdgeInsets.fromLTRB(170, 30, 10, 10),
                //margin: EdgeInsets.only(top: 80),
                decoration: BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage('images/rdd4.png'),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 140, 10, 10),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    labelText: 'USERNAME',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    hintText: "Enter your username",
                    hintStyle: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 230, 10, 10),
                child: TextField(
                  obscureText: true,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.arrow_forward_ios, color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    labelText: 'PASSWORD',
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.fromLTRB(10, 320, 10, 10),
                child: Material(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  child: MaterialButton(
                    onPressed: () async {
                      progbar = true;
                      try {
                        var signin =
                            await authentication.createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                        if (signin.additionalUserInfo.isNewUser == true) {
                          Navigator.pushNamed(context, "linuxcmd");
                          progbar = false;
                        }
                      } catch (exception) {
                        print(exception);
                      }
                      
                    },
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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