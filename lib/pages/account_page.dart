import 'package:flutter/material.dart';
import 'package:x_french/widgets/Submit_Button.dart';
import 'package:x_french/widgets/text_field.dart';

class AccountPage extends StatefulWidget {
AccountPage({super.key});

  final emailController =  TextEditingController();
  final passwordController =  TextEditingController();


  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 500
            ),
            child: Column(
              children: [
                Spacer(),
                Text('Sign in/up',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
              SizedBox(height: 30,),
              InputTextField(
                controller: widget.emailController,
                hintText: "email@.com",
                obscureText: false,
              ),
              SizedBox(height: 20,),
              InputTextField(
                controller: widget.passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              SizedBox(height: 10,),
              Text('Forgot Password?'),
              SizedBox(height: 20,),
              SubmitButton(),
              Spacer(),
            
              ],
              
            ),
          ),
        ),
      );
    
  }
}