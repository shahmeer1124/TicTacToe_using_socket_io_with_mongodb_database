import 'package:flutter/material.dart';
import 'package:tictactoe/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  final bool isreadonly;
  const CustomTextField(
      {Key? key,this.isreadonly=false, required this.controller, required this.hinttext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.blue,
          blurRadius: 5,
          spreadRadius: 2,
        )
      ]),
      child: TextField(
        readOnly: isreadonly,
          controller: controller,
          decoration: InputDecoration(
            fillColor: colorbg,
            filled: true,
            hintText: hinttext,
          )),
    );
  }
}
