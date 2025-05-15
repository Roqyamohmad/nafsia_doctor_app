import 'package:flutter/material.dart';

class DoctorChatPage extends StatelessWidget {
  final String sessionTitle;

  const DoctorChatPage({super.key, required this.sessionTitle});

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(sessionTitle),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                // رسائل تجريبية لعرض الشكل
                ChatBubble(
                    message: "مرحبًا، الجلسة هتبدأ قريبًا!", isDoctor: true),
                ChatBubble(message: "تمام، مستنيين", isDoctor: false),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'اكتب رسالة...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    // هنا تقدر تضيف منطق إرسال الرسائل
                    final msg = messageController.text.trim();
                    if (msg.isNotEmpty) {
                      messageController.clear();
                      // sendMessage(msg);
                    }
                  },
                  icon: const Icon(Icons.send, color: Colors.teal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isDoctor;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isDoctor,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isDoctor ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDoctor ? Colors.teal[200] : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(message),
      ),
    );
  }
}
