import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/resources/socket_methods.dart';

class TicTacToeBoard extends StatefulWidget {
  const TicTacToeBoard({Key? key}) : super(key: key);

  @override
  State<TicTacToeBoard> createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  @override
  void initState() {
    // TODO: implement initState
    _socketMethods.tappedListener(context);
    super.initState();
  }

  final SocketMethods _socketMethods = SocketMethods();

  void tapped(int index, RoomDataProvider roomDataProvider) {
    _socketMethods.tapGrid(index, roomDataProvider.roomdata['_id'],
        roomDataProvider.displayElements);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return ConstrainedBox(
      constraints:
          (BoxConstraints(maxHeight: size.height * 0.8, maxWidth: 500)),
      child: AbsorbPointer(
        absorbing: roomDataProvider.roomdata['turn']['socketId'] !=
            _socketMethods.socketClient.id,
        child: GridView.builder(
            itemCount: 9,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => tapped(index, roomDataProvider),
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  child: Center(
                    child: AnimatedSize(
                      duration: Duration(milliseconds: 200),
                      child: Text(
                        roomDataProvider.displayElements[index],
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            // ignore: prefer_const_literals_to_create_immutables
                            fontSize: 100,
                            shadows: [
                              Shadow(
                                  blurRadius: 40,
                                  color:
                                      roomDataProvider.displayElements[index] ==
                                              'o'
                                          ? Colors.red
                                          : Colors.blue)
                            ]),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
