import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/resources/game_methods.dart';
import 'package:tictactoe/resources/socket_client.dart';

import '../screens/gamescreen.dart';
import '../utils/utils.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;
//Emitter
  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {'nickname': nickname});
    }
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'nickname': nickname,
        'roomId': roomId,
      });
    }
  }

  void tapGrid(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketClient.emit('tap', {
        'index': index,
        'roomId': roomId,
      });
    }
  }

//Listener
  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on('Create Room Success', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateroomdata(room);
      Navigator.pushNamed(context, GameScreen.routename);
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on('JoinRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateroomdata(room);
      Navigator.pushNamed(context, GameScreen.routename);
    });
  }

  void errorOccurredListener(BuildContext context) {
    _socketClient.on('ErrorOccured', (data) {
      showSnackBar(context, data);
    });
  }

  void updateplayerListener(BuildContext context) {
    _socketClient.on('updatePlayers', (playerData) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateplayer1(playerData[0]);

      Provider.of<RoomDataProvider>(context, listen: false)
          .updateplayer2(playerData[1]);
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateroomdata(data);
    });
  }

  void tappedListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      roomDataProvider.updateDisplayElements(data['index'], data['choice']);
      roomDataProvider.updateroomdata(data['room']);
      GameMethods().checkWinner(context, _socketClient);
    });
  }

  void pointIncreaseListener(BuildContext context) {
    _socketClient.on('pointIncrease', (data) {
      var roomdataprovider =
          Provider.of<RoomDataProvider>(context, listen: false);
      if (data['socketId'] == roomdataprovider.player1.socketID) {
        roomdataprovider.updateplayer1(data);
      } else {
        roomdataprovider.updateplayer2(data);
      }
    });
  }

  void endgameListener(BuildContext context) {
    _socketClient.on('endgame', (data) {
      showdialogbox(context, '${data['nickname']} won the game');
      Navigator.popUntil(context, (route) => false);
    });
  }
}
