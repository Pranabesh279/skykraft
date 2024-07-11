import 'package:flutter/material.dart';
import 'package:skycraft/app/constants/theme_data.dart';

class ChatInput extends StatelessWidget {
  final Function(String) onSendPressed;
  const ChatInput({super.key, required this.onSendPressed});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: kWhiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: const TextStyle(
                color: kTitleColor,
                fontSize: 16,
              ),
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Type a message',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: kPrimaryColor),
            onPressed: () {
              if (controller.text.isEmpty) return;
              onSendPressed(controller.text);
              controller.clear();
            },
          )
        ],
      ),
    );
  }
}
