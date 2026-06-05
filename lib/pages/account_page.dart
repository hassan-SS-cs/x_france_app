import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  AccountPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_circle_outlined,
                    size: 100,
                    color: Colors.black,
                  ),
                  SizedBox(height: 20),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Colors.black, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isLoggedIn = true;
                      });
                    },
                    child: Text(
                      'Join us Now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('to discover more sight of France'),
                ],
              ),
            ),
            Expanded(
              child: isLoggedIn == false
                  ? Container()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign in/up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
                            controller: widget.emailController,
                            decoration: InputDecoration(
                              hintText: 'email@.com',
                              filled: true,
                              fillColor: Color.fromARGB(255, 250, 250, 250),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 211, 211, 211),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 111, 111, 111),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
                            controller: widget.passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: '. . . . . .',
                              filled: true,
                              fillColor: Color.fromARGB(255, 250, 250, 250),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 211, 211, 211),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 111, 111, 111),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('Forgot Password?'),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 112, 112, 112),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.all(18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Sign in/up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
