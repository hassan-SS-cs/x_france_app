import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:x_french/models/post.dart';

class AccountPage extends StatefulWidget {
  final List<Post> favorites;
  final bool isLoggedIn;
  final String username;
  final bool showForm;
  final Function(bool, String, bool) onAuthChanged;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  AccountPage({
    required this.favorites,
    required this.isLoggedIn,
    required this.username,
    required this.showForm,
    required this.onAuthChanged,
    super.key,
  });

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String emailError = '';
  String passwordError = '';
  RegExp emailRegex = RegExp(r'^[\w.-]+@[\w.-]+\.\w+$');
  RegExp passRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{6,}$');
  bool showPassword = false;
  final _player = AudioPlayer();

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
                  SizedBox(height: 50),
                  Icon(
                    Icons.account_circle_outlined,
                    size: 100,
                    color: Colors.black,
                  ),
                  SizedBox(height: 20),
                  widget.isLoggedIn
                      ? Text(
                          widget.username,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )
                      : SizedBox(),
                  SizedBox(height: 10),
                  widget.isLoggedIn
                      ? OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black,
                            side: BorderSide(color: Colors.black, width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          onPressed: () =>
                              widget.onAuthChanged(false, '', false),
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
                          onPressed: () =>
                              widget.onAuthChanged(false, '', true),
                          child: Text(
                            'Join us Now',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                  SizedBox(height: 10),
                  widget.isLoggedIn
                      ? Text('to change the other account')
                      : Text('to discover more sight of France'),
                ],
              ),
            ),
            Expanded(
              child: widget.isLoggedIn
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'My Favorites',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: widget.favorites.reversed
                                .toList()
                                .length,
                            itemBuilder: (context, i) {
                              final post = widget.favorites.reversed
                                  .toList()[i];
                              return Card(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              post.title,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              post.userId,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              post.datetime,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              post.body,
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Image.network(
                                        post.imageUrl,
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : widget.showForm == false
                  ? Container()
                  : Column(
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
                                onLongPressStart: (_) =>
                                    setState(() => showPassword = true),
                                onLongPressEnd: (_) =>
                                    setState(() => showPassword = false),
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
                            if (emailError.isNotEmpty ||
                                passwordError.isNotEmpty)
                              return;
                            if (widget.emailController.text.isEmpty ||
                                widget.passwordController.text.isEmpty)
                              return;
                            widget.onAuthChanged(
                              true,
                              widget.emailController.text.split('@')[0],
                              true,
                            );
                            _player.play(AssetSource('Success.mp3'));
                          },
                          child: Text(
                            'Sign in/up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            final url = Uri.parse(
                              'https://www.apple.com/legal/privacy/',
                            );
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          },
                          child: Text(
                            'READ USER AGREEMENT',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blue,
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