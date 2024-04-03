import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:new_utibu_health_app/common/utils/app_constants.dart';



class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];

  Future<void> _sendMessage(String message) async {
    final response = await http.post(
      Uri.parse(AppConstants.API_KEY_OPENAI),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer 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',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'system', 'content': message},
        ],
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        _messages.add(data['choices'][0]['message']['content']);
      });
    } else {
      print('Failed to send message');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: const Icon(Icons.arrow_back,color: Colors.white,size: 35)),
        backgroundColor: Colors.pink.shade200,
        title: const Text('Lets Chat about your health Today',style: TextStyle(fontSize: 25,color: Colors.white),),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[200], 
              padding:const  EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  String message = _messages[index];
                  String displayMessage = message.startsWith('User:')
                      ? message.substring('User:'.length)
                      : message;
                  return Align(
                    alignment: message.startsWith('User:') ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin:const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: message.startsWith('User:') ? Colors.blue : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        displayMessage,
                        style: TextStyle(
                          color: message.startsWith('User:') ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const  EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const  SizedBox(width: 8),
                IconButton(
                  icon:const Icon(Icons.send),
                  onPressed: () {
                    String message = _messageController.text.trim();
                    if (message.isNotEmpty) {
                      setState(() {
                        _messages.add('User: $message');
                      });
                      _sendMessage(message);
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
