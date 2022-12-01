import 'package:flutter/material.dart';
import 'package:tictactoe/reponsive/responsive.dart';
import 'package:tictactoe/resources/socket_methods.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/customtextfield.dart';

class CreateRoomScreen extends StatefulWidget {
  static String create_room = '/create_room';
  const CreateRoomScreen({Key? key}) : super(key: key);

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final SocketMethods _socketMethods = SocketMethods();
  final TextEditingController _namecontroller = TextEditingController();

  @override
  void initState() {
    _socketMethods.createRoomSuccessListener(context);
    super.initState();
  }

  @override
  void dispose() {
    _namecontroller.dispose();
    super.dispose();
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
                  text: 'Create Room',
                  fontsize: 70.0),
              SizedBox(
                height: size.height * 0.08,
              ),
              CustomTextField(
                  controller: _namecontroller, hinttext: "Enter your Name"),
              SizedBox(
                height: size.height * 0.045,
              ),
              CustomButton(
                  ontap: () => _socketMethods.createRoom(_namecontroller.text),
                  text: "Create")
            ],
          ),
        ),
      ),
    );
  }
}
