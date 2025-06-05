import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message;
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final Timestamp timestamp;
  final String type;

  Message({
    required this.message,
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.timestamp,
    required this.type
  });

  // Convert Message object to a Map
  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'timestamp': timestamp,
      'type':type
    };
  }

  // Create a Message object from a Map
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      message: map['message'],
      senderId: map['senderId'],
      senderEmail: map['senderEmail'],
      receiverId: map['receiverId'],
      timestamp: map['timestamp'],
      type: map['type']
    );
  }
}
