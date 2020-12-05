import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:linux_with_flutter/linuxcmd.dart';
import 'package:linux_with_flutter/login.dart';
import 'package:linux_with_flutter/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Hotreload());
}

class Hotreload extends StatelessWidget {
  build(BuildContext c1) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "login",
      //initialRoute: "signin",
      routes: {
        "signin": (context) => Signin(),
        "login": (context) => Login(),
        "linuxcmd": (context) => Lcmd(),
      },
    );
  }
}