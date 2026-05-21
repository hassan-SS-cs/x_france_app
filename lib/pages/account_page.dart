import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return   Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      alignment: Alignment.center,
      child: Text('Account',style: TextStyle(fontSize: 40),),
    );
  }
}