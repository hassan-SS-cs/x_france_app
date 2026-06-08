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
  String emailError = '';
  String passwordError = '';
  RegExp emailRegex = RegExp(r'^[\w.-]+@[\w.-]+\.\w+$');
  RegExp passRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{6,}$');
  bool showPassword = false;
  bool showForm = false;
  String username = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 50,),
                  Icon(
                    Icons.account_circle_outlined,
                    size: 100,
                    color: Colors.black,
                  ),
                  SizedBox(height: 20),
                  isLoggedIn
                      ? Text(
                          username,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )
                      : SizedBox(),
                  SizedBox(height: 10),
                  isLoggedIn
                      ? OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black,
                            side: BorderSide(color: Colors.black, width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              isLoggedIn = false;
                              showForm = false;
                              username = '';
                            });
                          },
                          child: Text(
                            'Sign out',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black,
                            side: BorderSide(color: Colors.black, width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          onPressed: () => setState(() => showForm = true),
                          child: Text(
                            'Join us Now',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                  SizedBox(height: 10),
                  isLoggedIn
                      ? Text('to change the other account')
                      : Text('to discover more sight of France'),
                ],
              ),
            ),
            Expanded(
              child: showForm == false
                  ? Container()
                  : isLoggedIn == false
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 150),
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
                            onChanged: (value) {
                              setState(() {
                                emailError = emailRegex.hasMatch(value)
                                    ? ''
                                    : 'Invalid Email';
                              });
                            },
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
                        if (emailError.isNotEmpty)
                          Text(emailError, style: TextStyle(color: Colors.red)),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                passwordError = passRegex.hasMatch(value)
                                    ? ''
                                    : 'Invalid Password';
                              });
                            },
                            controller: widget.passwordController,
                            obscureText: !showPassword,
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
                              suffixIcon: GestureDetector(
                                onLongPressStart: (_) {
                                  setState(() => showPassword = true);
                                },
                                onLongPressEnd: (_) {
                                  setState(() => showPassword = false);
                                },
                                child: Icon(Icons.remove_red_eye),
                              ),
                            ),
                          ),
                        ),
                        if (passwordError.isNotEmpty)
                          Text(
                            passwordError,
                            style: TextStyle(color: Colors.red),
                          ),
                        SizedBox(height: 10),
                        Text('Forgot Password?'),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              112,
                              112,
                              112,
                            ),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.all(18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              username = widget.emailController.text.split(
                                '@',
                              )[0];
                              isLoggedIn = true;
                            });
                          },
                          child: Text(
                            'Sign in/up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
