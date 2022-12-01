import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/screens/create_room_screen.dart';
import 'package:tictactoe/screens/gamescreen.dart';
import 'package:tictactoe/screens/join_room_screen.dart';
import 'package:tictactoe/screens/main_menu_screen.dart';
import 'package:tictactoe/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: colorbg,
        ),
        routes: {
          MainMenuScreen.routename: (context) => const MainMenuScreen(),
          JoinRoomScreen.joinroom: (context) => const JoinRoomScreen(),
          GameScreen.routename: (context) => const GameScreen(),
          CreateRoomScreen.create_room: (context) => const CreateRoomScreen(),
        },
        initialRoute: MainMenuScreen.routename,
      ),
    );
  }
}
