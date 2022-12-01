import 'package:flutter/material.dart';
import 'package:tictactoe/reponsive/responsive.dart';
import 'package:tictactoe/screens/create_room_screen.dart';

import '../widgets/custom_button.dart';
import 'join_room_screen.dart';

class MainMenuScreen extends StatelessWidget {
  static String routename = "/main_menu";
  const MainMenuScreen({Key? key}) : super(key: key);

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.joinroom);
  }

  void createroom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.create_room);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Responsive(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            ontap: () {
              createroom(context);
            },
            text: "Create Room",
          ),
         const SizedBox(
            height: 20,
          ),
          CustomButton(
            ontap: () {
              joinRoom(context);
            },
            text: "join Room",
          ),
        ],
      ),
    ));
  }
}
