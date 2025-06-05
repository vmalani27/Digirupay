import 'package:flutter/material.dart';

class PaymentTile extends StatelessWidget {
  final String amount;
  final String receiverName;
  final String? senderName;
  final bool isCurrentUser; // True if the user is the sender

  const PaymentTile({
    super.key,
    required this.amount,
    required this.isCurrentUser,
    required this.receiverName,
    required this.senderName,
  });

  @override
  Widget build(BuildContext context) {
    // If the current user is not the sender, they are receiving money
    bool isReceiving = !isCurrentUser;

    // Print sender and receiver names in the console
    if (isReceiving) {
      print("Receiver: $receiverName");
      print("Sender: ${senderName ?? "Unknown Sender"}");
    } else {
      print("Sender: ${senderName ?? "Unknown Sender"}");
      print("Receiver: $receiverName");
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Icon / Avatar
          CircleAvatar(
            backgroundColor: isCurrentUser ? Colors.grey.shade800 : Colors.blue.shade300,
            child: senderName != null && senderName!.isNotEmpty
                ? Text(
                    senderName![0].toUpperCase(), // Show first letter of sender's name
                    style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  )
                : const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12), // Spacing

          // Transaction Message
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Transaction type: "Payment to you" or "Payment to receiver"
                Text(
                  isReceiving
                      ? "Payment to you" // If receiving, show "Payment to you"
                      : "Payment to ${receiverName ?? 'Unknown Receiver'}", // If sending, show "Payment to receiver"
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isCurrentUser ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                // Amount Display
                Text(
                  "${isReceiving ? '+' : '-'} ₹ $amount", // Add + if receiving, - if sending
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isReceiving ? Colors.green.shade700 : Colors.red.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
