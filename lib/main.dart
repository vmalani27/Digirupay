import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minimalchat/services/auth/auth_gate.dart';
import 'package:minimalchat/services/auth/log_or_reg.dart';
import 'package:minimalchat/firebase_options.dart';
// import 'package:minimalchat/pages/register.dart';
import 'package:minimalchat/themes/light_mode.dart';
// import 'pages/login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: lightMode,
    );
  }
}