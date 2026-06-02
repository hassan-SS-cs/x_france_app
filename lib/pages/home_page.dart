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
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: ListenableBuilder(
              listenable: _homeViewModel,
              builder: (context, child) {
                if (_homeViewModel.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                return Container(
                  color: const Color.fromARGB(255, 250, 250, 250),
                  child: MasonryGridView.builder(
                    gridDelegate:
                        SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                    itemCount: _homeViewModel.posts.length,
                    itemBuilder: (context, i) {
                      final post = _homeViewModel.posts[i];
                      return Card(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPost = post;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _homeViewModel.posts[i].title,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
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
                ? ColoredBox(
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        children: [
                          Image.network(
                            'assets/Welcome_img.png',
                            width: 300,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            'Welcome To France',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(24),
                    child: SingleChildScrollView(
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

                          SizedBox(height: 60),
                          Image.network(
                            selectedPost!.imageUrl,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 20),
                          Text(
                            selectedPost!.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            spacing: 10,
                            children: [
                              Text(selectedPost!.userId),
                              Text(selectedPost!.datetime),
                            ],
                          ),
                          SizedBox(height: 50),
                          Text(
                            selectedPost!.body,
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}