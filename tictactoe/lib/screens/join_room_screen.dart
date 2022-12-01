import 'package:flutter/material.dart';
import 'package:tictactoe/resources/socket_methods.dart';

import '../reponsive/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/customtextfield.dart';

class JoinRoomScreen extends StatefulWidget {
  static String joinroom = '/join_room';
  const JoinRoomScreen({Key? key}) : super(key: key);

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _gameIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void dispose() {
    _gameIdController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _socketMethods.errorOccurredListener(context);
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.updateplayerListener(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                  shadow: [Shadow(blurRadius: 40, color: Colors.blue)],
                  text: 'Join Room',
                  fontsize: 70.0),
              SizedBox(
                height: size.height * 0.08,
              ),
              CustomTextField(
                  controller: _nameController, hinttext: "Enter your Name"),
              SizedBox(
                height: size.height * 0.045,
              ),
              CustomTextField(
                  controller: _gameIdController, hinttext: "Enter GameID"),
              SizedBox(
                height: size.height * 0.045,
              ),
              CustomButton(
                  ontap: () => _socketMethods.joinRoom(
                      _nameController.text, _gameIdController.text),
                  text: "Join")
            ],
          ),
        ),
      ),
    );
  }
}
