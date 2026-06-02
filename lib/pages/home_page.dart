import 'package:flutter/material.dart';
import 'package:x_french/pages/home_viewmodel.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:x_french/models/post.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
final HomeViewModel _homeViewModel = HomeViewModel();
Post? selectedPost;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Posts',style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Color.fromARGB(255, 250, 250, 250),
      ),
      body:Row(
        children: [
          Expanded(
            flex: 2,
            child: ListenableBuilder(
              listenable: _homeViewModel,
              builder: (context, child) { 
                if(_homeViewModel.isLoading){
                  return Center(child: CircularProgressIndicator());
                }
                
                 return Container(
                      color: const Color.fromARGB(255, 250, 250, 250),
                       child: MasonryGridView.builder(
                              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: 2,
                         ),
                         itemCount: _homeViewModel.posts.length,
                         itemBuilder: (context, i) {
                          final post = _homeViewModel.posts[i];
                           return Card(
                            color: const Color.fromARGB(255, 255, 255, 255),
                             child: GestureDetector(
                                onTap:(){
                                setState(() {
                                  selectedPost = post;
                                });
                               },
                               child: Padding(
                                 padding: EdgeInsets.all(15),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text(_homeViewModel.posts[i].title,
                                                         style: TextStyle(fontWeight: FontWeight.bold)),
                                     SizedBox(height: 10),
                                     Text(_homeViewModel.posts[i].body),
                                   ],
                                    ),
                                  ),
                             ),
                              );
                            },
                             ),
                     );
              },
            ),
          ),
          VerticalDivider(width: 1),
          Expanded(
            flex: 3,
            child: selectedPost == null
            ?ColoredBox(
              color: Colors.white,
              child: Center(
                child: Column(
                  children: [
                    Image.network('assets/Welcome_img.png',width: 500,height: 500, fit:BoxFit.cover),
                    Text('Welcome To France')
                  ],
                ),
              ),
            )
            :Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                selectedPost = null;
                              });
                            },
                          ),
                        ),
                        Text(selectedPost!.title),
                        SizedBox(height: 100,),
                        Text(selectedPost!.body)
                      ],
                    ),
                  ),
            )
        ],
      )
    );
  }
}