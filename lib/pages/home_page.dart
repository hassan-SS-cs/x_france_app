import 'package:flutter/material.dart';
import 'package:x_french/models/post.dart';
import 'package:x_french/services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  late List<Post> data =[];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
 ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder:(BuildContext context, int index){
      } ,
    ),
          Container(
          color: const Color.fromARGB(255, 255, 255, 255),
          alignment: Alignment.center,
          child: Text('Home',style: TextStyle(fontSize: 40),),
              ),
        ],
      ),
   
    );
    
    
   
  }
}