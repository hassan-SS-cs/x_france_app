import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      alignment: Alignment.center,
      child: Text('Home',style: TextStyle(fontSize: 40),),
    );
  }
}