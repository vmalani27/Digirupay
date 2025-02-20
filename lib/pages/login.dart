import 'package:flutter/material.dart';
import 'package:minimalchat/services/auth/auth_service.dart';
import 'package:minimalchat/components/my_button.dart';
import 'package:minimalchat/components/my_textfield.dart';

class LoginPage extends StatelessWidget {

  //email and password controller
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _PasswordController = TextEditingController();

  LoginPage({super.key,required this.onTap});



  void login(BuildContext context) async {
    final authService=AuthService();

    try{
      await authService.signinWithEmailPassword(_emailController.text, _PasswordController.text);
    }

    catch(e){
      showDialog(context: context, builder: (context)=>AlertDialog(
        
        title: Text(e.toString()) 
          
          ));
    }


  }
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: 
      Center(    
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //logo
          Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.currency_rupee,
          size: 100,
          color: Colors.black,
        ),
        SizedBox(height: 5), // Adjust spacing if needed
      ],
    ),
    
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start, // Ensures proper alignment
      children: [
        Text(
          "Welcome",
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
          ),
        ),
        Text(
          "Back",
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
          ),
        ),
      ],
    ),
  ],
          ),
          
          //email text field

          const SizedBox(height: 50,),

          MyTextfield(hintText: "E-mail",controller: _emailController,obscureText: false,),
          //pw 
          const SizedBox(height: 10,),

          MyTextfield(hintText: "Password",controller: _PasswordController,obscureText: true,),

          //login 
          TextButton(style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),),
          onPressed: () { },child: Text('Fogot Password?'),), 

          MyButton(
            onTap: ()=>login(context),
            ButtText: "Login"),


          //register
          const SizedBox(height: 10,),


          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          
            Text("Not a member?", style: TextStyle(color: Theme.of(context).colorScheme.primary),),


          TextButton(style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll<Color>(Theme.of(context).colorScheme.primary),),
          onPressed: onTap,child: Text('Register Now'),), 
          ]
          ),
        ],
      ),
    ));
  }
}