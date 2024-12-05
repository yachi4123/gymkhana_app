import 'package:flutter/material.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 400,
      color: Colors.lightBlueAccent,
      child: Center(child: Text("Welcome")),
    );
  }
}
