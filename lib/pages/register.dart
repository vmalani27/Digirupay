import 'package:flutter/material.dart';
import 'package:minimalchat/services/auth/auth_service.dart';
import 'package:minimalchat/components/my_button.dart';
import 'package:minimalchat/components/my_textfield.dart';



class Register extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _PasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _depositAmount = TextEditingController();
  Register({super.key,required this.onTap});


  void register(BuildContext context) async{
    
    
    final authservice= AuthService();

    if(_PasswordController.text==_confirmPasswordController.text){
      try{
        String fullname= _firstName.text.toUpperCase()+" "+ _lastName.text.toUpperCase();
        print("full name: $fullname");
    await authservice.registerWithEmailPassword(_emailController.text, _PasswordController.text, fullname);}
    catch(e){
      showDialog(context: context, builder: (context)=>AlertDialog(
        title: Text(e.toString()),
      ));

    }
  }
  else{
    showDialog(context: context, builder: (context)=>AlertDialog(title: Text("Passwords dont match"),));
  }
  
  
  
  }

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: 
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
          "Please",
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
          ),
        ),
        Text(
          "Sign up",
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
          ),
        ),
      ],
    ),
  ],
          ),

          const SizedBox(height: 50,),

          MyTextfield(hintText: "E-mail",controller: _emailController,obscureText: false,),
          //pw 
          const SizedBox(height: 40,),



        
              MyTextfield(hintText: "First Name", controller: _firstName, obscureText: false),

              const SizedBox(height: 10,),

              MyTextfield(hintText: "Last Name", controller: _lastName, obscureText: false),


          const SizedBox(height: 40,),

          MyTextfield(hintText: "Password",controller: _PasswordController,obscureText: true,),
          const SizedBox(height: 10,),

          MyTextfield(hintText: "Repeat Password",controller: _confirmPasswordController,obscureText: true,),

          //login 
          TextButton(style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),),
          onPressed: () { },child: Text('learn more'),), 

          MyButton(
            onTap: ()=> register(context),
            ButtText: "Register Now"),


          //register
          const SizedBox(height: 10,),


          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          
            Text("Already a Member?", style: TextStyle(color: Theme.of(context).colorScheme.primary),),


          TextButton(style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll<Color>(Theme.of(context).colorScheme.primary),),
          onPressed: onTap,child: Text('Login Now'),), 
          ]
          ),
            ],
          ),
        ),
      
    );
  }
}