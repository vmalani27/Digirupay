import 'package:flutter/material.dart';
import 'package:minimalchat/components/chat_bubble.dart';
import 'package:minimalchat/components/payment_tile.dart';
import 'package:minimalchat/services/auth/auth_service.dart';
import 'package:minimalchat/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverId;
  final String recievername;

  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverId,
    required this.recievername,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isSendingPayment = false; // Toggle between chat and payment mode

  // Services
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // Function to send messages or payments
  void sendMessage() async {
    if (_messageController.text.isEmpty) return;

    String message = _messageController.text.trim();
    _messageController.clear();

    if (_isSendingPayment) {
      await _chatService.sendMessage(widget.receiverId, message, type: "payment");
    } else {
      await _chatService.sendMessage(widget.receiverId, message, type: "text");
    }

    setState(() {
      _isSendingPayment = false; // Reset to normal text mode
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
  preferredSize: Size.fromHeight(40.0), // Set the height to 100.0 or any value you prefer
  child: AppBar(
    title: Text(
      widget.recievername
          .toLowerCase()
          .split(" ")
          .map((e) => e.capitalize)
          .join(" "),
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    backgroundColor: Theme.of(context).colorScheme.tertiary,
    centerTitle: true,
  ),
),

      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildMessageInput(),
        ],
      ),
    );
  }

  // Build the message list
  Widget _buildMessageList() {
    String senderId = _authService.getcurrentuser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverId, senderId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Error loading messages"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You and ${widget.recievername.capitalize} have no messages yet.",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                const Text("Start your conversation now!"),
              ],
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          children: snapshot.data!.docs.map<Widget>((doc) => _buildMessageTile(doc)).toList(),
        );
      },
    );
  }

  // Build a single message tile
  Widget _buildMessageTile(dynamic doc) {
    String senderId = _authService.getcurrentuser()!.uid;
    var data = doc.data() as Map<String, dynamic>;

    String? chatsender = data['senderId'] ?? data['senderID'];
    if (chatsender == null) {
      print("Error: Neither 'senderId' nor 'senderID' exists in the document: $data");
      return Container();
    }

    bool isSender = chatsender == senderId;
    String messageType = data['type'] ?? "text"; // Determine message type

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: messageType == "payment"
            ? PaymentTile(
                amount: data['message'],
                isCurrentUser: isSender,
                receiverName: isSender ? widget.recievername.capitalize : "You",
                senderName: isSender ? "You" : widget.recievername.capitalize,
              )
            : ChatBubble(
                Message: data['message'],
                iscurrentUser: isSender,
              ),
      ),
    );
  }

  // Build the message input field
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              keyboardType: _isSendingPayment ? TextInputType.number : TextInputType.text,
              decoration: InputDecoration(
                hintText: _isSendingPayment ? "Enter amount" : "Type a message...",
                prefixIcon: _isSendingPayment
                    ? const Icon(Icons.currency_rupee, color: Colors.green)
                    : const Icon(Icons.chat, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                _isSendingPayment = !_isSendingPayment; // Toggle mode
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: _isSendingPayment ? Colors.green : Colors.grey[300],
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.currency_rupee, color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: sendMessage,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String get capitalize =>
      this.isNotEmpty ? this[0].toUpperCase() + this.substring(1).toLowerCase() : '';
}
