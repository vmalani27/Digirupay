import 'package:flutter/material.dart';
import 'package:minimalchat/pages/banking_services.dart';
import 'package:minimalchat/services/auth/auth_service.dart';
import 'package:minimalchat/pages/settingspage.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});


  void logout() async {
    final authservice=AuthService();
    authservice.signout();

  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            // mainAxisAlignment: MainAxisAlignment.,
            children: [
              //logo
              DrawerHeader(
                child: Center(
                  child: Column(
                    children:[ 
                      
                      
                      Icon(
                      Icons.currency_rupee_outlined,
                      color: Theme.of(context).colorScheme.primary,
                      size: 64,),
          
                      SizedBox(height: 10,),
          
                      Text("DigiRupay",),
          
                      
          
            ]),
          
                  
                  
                  
                  )
                  ),
              //home
          

              

              Padding(padding: const EdgeInsets.only(left: 25),
              child: ListTile(
                title: Text("People"),
                leading: Icon(Icons.people),
                onTap: () {
                Navigator.pop(context);                 
                },
              ),
              
              
              ),


              Padding(padding: const EdgeInsets.only(left: 25),
              child: ListTile(
                title: Text("Banking Services"),
                leading: Icon(Icons.currency_rupee_rounded),
                onTap: () {
                Navigator.pop(context);      
                Navigator.push(context, MaterialPageRoute(builder: (context)=> BankingServicesPage()));
           
                },
              ),
              ),
          
              Padding(padding: const EdgeInsets.only(left: 25),
              child: ListTile(
                title: Text("Your Account"),
                leading: Icon(Icons.verified_user),
                onTap: () {
                Navigator.pop(context);                 
                },
              ),
              
              
              ),
          
              //settings list view
               Padding(padding: const EdgeInsets.only(left: 25),
              child: ListTile(
                title: Text("DigiRupay Settings"),
                leading: Icon(Icons.settings),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Settingspage()));
                  
                },
              ),
              
              
              ),
          
              //logout
          
          
            ],
          ),

               Padding(padding: const EdgeInsets.only(left: 25),
              child: ListTile(
                title: Text("L O G O U T"),
                leading: Icon(Icons.logout),
                onTap: logout,
              ),
              
              
              ),
        ],
      ),
    );
  }
}