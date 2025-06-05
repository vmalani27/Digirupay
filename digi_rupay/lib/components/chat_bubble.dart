import 'package:flutter/material.dart';


class ChatBubble extends StatelessWidget {

  final String Message;

  final bool iscurrentUser;
  const ChatBubble({super.key, required this.Message, required this.iscurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: iscurrentUser? Colors.black : Colors.grey.shade500,
        borderRadius: BorderRadius.circular(10),
      
      
      ),
      
      child: Text(Message, style: TextStyle(color: iscurrentUser ? Colors.white : Colors.black,),),
    
    
    
    );


  }
}