import 'package:flutter/material.dart';


class UserTile extends StatelessWidget {
  
  final String text;
  final void Function()? onTap;
  
  const UserTile({
    super.key,
    required this.onTap, 
    required this.text});





  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 15,horizontal:10),
        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 20),

        child: Row(
          children: [
            //Icon
            Icon(Icons.person),
            const SizedBox(width: 15,),
            Text(text),

            //User Name
          ],
        ),
      ),
    );
  }
}



