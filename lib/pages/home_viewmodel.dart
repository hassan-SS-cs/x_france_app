import 'package:flutter/material.dart';
import 'package:x_french/services/api_service.dart';
import 'package:x_french/models/post.dart';
class HomeViewModel extends ChangeNotifier {
ApiService apiService =ApiService();

final List<Post> posts = [];


bool isLoading =  true;

HomeViewModel(){
  fetchPost();
}

void fetchPost()async {
try{
  debugPrint('Fetching posts...');

 posts.addAll(await apiService.getPost());

 isLoading= false;

 notifyListeners();
}catch(e){
  debugPrint('Error fetching posts: $e');
}
}

}