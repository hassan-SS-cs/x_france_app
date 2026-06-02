import 'package:flutter/material.dart';
import 'package:x_french/widgets/app_navigation.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromARGB(
            255,
            255,
            255,
            255,
          ), // Main color for buttons and primary components
          onPrimary: Color.fromARGB(255, 255, 255, 255), //idk
          secondary: Color.fromARGB(255, 255, 255, 255), // idk
          onSecondary: Color.fromARGB(255, 255, 255, 255), // idk
          error: Colors.red,
          onError: Colors.white,
          surface: Color.fromARGB(
            255,
            255,
            255,
            255,
          ), // Backgrounds for cards...
          onSurface: Colors.black, // idk
        ),
      ),

      debugShowCheckedModeBanner: false,
      home: AppNavigation(),
    ),
  );
}
