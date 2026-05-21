import 'package:x_french/models/post.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ApiService {
  final String baseUri = "https://jsonplaceholder.typicode.com/posts/";


Future<Post> getPost(int id) async{
  try{
    Response response = await get(Uri.parse("$baseUri$id"));
    Map <String, dynamic> data = jsonDecode(response.body);
   return Post.fromJson(data);
  }catch(e){
    print('you have an error: $e');
    rethrow;
  }
}
}
