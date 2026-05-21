import 'package:http/http.dart';
import 'dart:convert';

main()async{
Response response = await get(Uri.parse("https://jsonplaceholder.typicode.com/posts/1"));
Post post=Post.fromJson(jsonDecode(response.body));
print(post.body);
}

class Post {
  late final String title;
  late final String body;
  Post(this.title,this.body);
   Post.fromJson(Map<String, dynamic>json){
    title=json["title"];
    body=json["body"];
  }
}