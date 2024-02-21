import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:solution_challenge/common/global_variables.dart';
import 'package:solution_challenge/common/utils.dart';
import 'package:solution_challenge/screens/home_screen.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});
  static const String routeName = '/chat_bot';

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  ChatUser user = ChatUser(id: '1', firstName: "User");
  ChatUser geminiBot = ChatUser(id: "2", firstName: "Health Bot");
  List<ChatMessage> messages = <ChatMessage>[];
  List<ChatUser> _typing = <ChatUser>[];

  String geminiUrl = dotenv.get("GEMINI_URL");
  String geminiApi = dotenv.get("GEMINI_API_KEY");

  getData(ChatMessage m) async {
    _typing.add(geminiBot);
    messages.insert(0, m);

    var data = jsonEncode({"user_input": m.text});

    setState(() {});

    try {
      http.Response response = await http.post(
        Uri.parse(geminiUrl),
        body: data,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result);

        ChatMessage responseMessage = ChatMessage(
          text: result['response'],
          user: geminiBot,
          createdAt: DateTime.now(),
        );
        messages.insert(0, responseMessage);
      } else {
        // Handle non-successful response (e.g., show an error message)
        print('Server error: ${response.body}');
        showSnackbar(context, 'Error communicating with the server.');
      }
    } catch (e) {
      print(e.toString());
      showSnackbar(context, e.toString());
    } finally {
      _typing.remove(geminiBot);
      setState(
          () {}); // Update the UI to remove the bot from typing status and show the new message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
          title: Row(
            children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, HomeScreen.routeName, (route) => false);
                  },
                  icon: ImageIcon(
                    AssetImage('assets/images/back_button_AI.png'),
                    color: GlobalVariables.secondary_color,
                    size: 56,
                  ),
                ),
              Container(
                margin: EdgeInsets.only(left: 70),
                child: Text(
                  "Nutri.AI",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        backgroundColor: Colors.white,
      ),
      body: DashChat(
        currentUser: user,
        onSend: (ChatMessage message) {
          getData(message);
        },
        typingUsers: _typing,
        messages: messages,
        inputOptions: InputOptions(
          inputDecoration: InputDecoration(

            contentPadding: EdgeInsets.all(12.0),
            hintText: "Type here ...",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Colors.black,
                width: 2.0,
              )
            )
          ),
          inputToolbarMargin: EdgeInsets.only(bottom: 15),
          alwaysShowSend: false,
          cursorStyle: CursorStyle(
            color: Colors.black,
          ),
        ),
        messageOptions: MessageOptions(
          containerColor: GlobalVariables.secondary_color,
          currentUserContainerColor: GlobalVariables.tertiary_color,
          currentUserTextColor: Colors.black,
          avatarBuilder: AvatarBuilder,
        ),
      ),
    );
  }

  Widget AvatarBuilder(
      ChatUser user, Function? onTapAvatar, Function? onLongPressAvatar) {
    return Center(
      child: Image.asset(
        'assets/images/google_logo.png',
        height: 30,
        width: 30,
      ),
    );
  }
}
