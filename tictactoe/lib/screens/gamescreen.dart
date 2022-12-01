import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/resources/socket_methods.dart';

import '../views/score_board.dart';
import '../views/tictactoe_board.dart';
import '../views/waiting_lobby.dart';

class GameScreen extends StatefulWidget {
  static String routename = '/game';
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();
  @override
  void initState() {
    // TODO: implement initState
    _socketMethods.updateRoomListener(context);
    _socketMethods.updateplayerListener(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endgameListener(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: true);

    return Scaffold(
        body: roomDataProvider.roomdata['isjoin']
            ? WaitingLobby()
            : SafeArea(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ScoreBoard(),
                  TicTacToeBoard(),
                  Text(
                      '${roomDataProvider.roomdata['turn']['nickname']}\'s turn')
                ],
              )));
  }
}
