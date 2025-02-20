import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimalchat/components/user_tile.dart';
import 'package:minimalchat/services/auth/auth_gate.dart';
import 'package:minimalchat/services/auth/auth_service.dart';
import 'package:minimalchat/components/my_drawer.dart';
import 'package:minimalchat/services/chat/chat_service.dart';
import 'package:minimalchat/pages/chatpage.dart';



class Homepage extends StatelessWidget {
  Homepage({super.key});


  final ChatService _chatService=ChatService();
  final AuthService _authService=AuthService();


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        
        title: Text("People",style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Theme.of(context).colorScheme.primary,
      
      ),
      drawer: MyDrawer(),

      body: _builduserlist(),
    );
  }




Widget _builduserlist(){
  return StreamBuilder(
    stream: _chatService.getUserStream(), 
    builder: (context,snapshot){
      if(snapshot.hasError){
        return const Text("Error");
      }
      if(snapshot.connectionState==ConnectionState.waiting){
        return const Text("Loading");
      }


      return ListView(
        children: snapshot.data!.map<Widget>((UserData)=> _buildUserListItem(UserData,context)).toList(),
      );
    });
}

Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
  // Convert both emails to lowercase for a case-insensitive comparison
  final currentUserEmail = _authService.getcurrentuser()!.email?.toLowerCase();
  final userEmail = userData["email"].toString().toLowerCase();

  if (userEmail != currentUserEmail) {
    // Debugging: Print email for verification
    print("UserData Email: $userEmail");
    print("Current User Email: $currentUserEmail");

    return UserTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              receiverEmail: userData["email"],
              receiverId: userData["uid"],
              recievername: userData["full name"],
            ),
          ),
        );
      },
      text: userData["email"],
    );
  } else {
    // Skip rendering for the current user
    return const SizedBox.shrink();
  }
}



}