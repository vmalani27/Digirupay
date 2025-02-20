import 'package:flutter/material.dart';
import 'package:minimalchat/pages/login.dart';
import 'package:minimalchat/pages/register.dart';


class LogOrReg extends StatefulWidget {
  const LogOrReg({super.key});

  @override
  State<LogOrReg> createState() => _LogOrRegState();
}

class _LogOrRegState extends State<LogOrReg> {
  
  
  
  bool showLoginPage=true;

  void togglepages(){
    setState(() {
      showLoginPage=!showLoginPage;
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(onTap: togglepages,);
    }
    else{
      return Register(onTap: togglepages,);
    }

  }
}