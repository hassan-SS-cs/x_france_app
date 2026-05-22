import 'package:x_french/models/post.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ApiService {
  final String baseUri = "https://jsonplaceholder.typicode.com/posts/";


Future<List<Post>> getPost() async{
    Response response = await get(Uri.parse("$baseUri"));
  if(response.statusCode ==200){
   List<dynamic> data = jsonDecode(response.body);
   return data.map((item)=> Post.fromJson(item)).toList();
  }else{
    throw Exception('Failed to get Post');
  }
 
}
}
