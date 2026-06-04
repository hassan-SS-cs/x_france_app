import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool isSwapped = false;
  @override
  Widget build(BuildContext context) {
    final listPanel = Expanded(
      flex: 2,
      child: DragTarget(
        onAcceptWithDetails: (details) {
          if (details.data == "details") {
            setState(() {
              isSwapped = !isSwapped;
            });
          }
        },
        builder: (context, candidateData, rejectedData) {
          return Draggable(
            data: "list",
            feedback: Container(child: Text('List Panel'),),
            child: ListenableBuilder(
              listenable: _homeViewModel,
              builder: (context, child) {
                if (_homeViewModel.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return MasonryGridView.builder(
                  gridDelegate:
                      SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                  itemCount: _homeViewModel.posts.length,
                  itemBuilder: (context, i) {
                    final post = _homeViewModel.posts[i];
                    return Container(
                      decoration: BoxDecoration(
                        color: post.title == selectedPost?.title
                            ? const Color.fromARGB(255, 223, 223, 223)
                            : const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Card(
                        elevation: 2,
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
                                Image.network(
                                  _homeViewModel.posts[i].imageUrl,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  _homeViewModel.posts[i].title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );

    final detailPanel = Expanded(
      flex: 3,
      child: DragTarget(
        onAcceptWithDetails: (details) {
          if (details.data == "list") {
            setState(() {
              isSwapped = !isSwapped;
            });
          }
        },
        builder: (context, candidateData, rejectedData) {
          return Draggable(
            data: 'details',
            feedback: Container(child: Text('details Panel'),),
            child: selectedPost == null
                ? Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/Welcome_img.png',
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
                  )
                : SingleChildScrollView(
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
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              SizedBox(height: 60),
                              Image.network(
                                selectedPost!.imageUrl,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      selectedPost!.title,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.copy),
                                    tooltip: 'Copy title',
                                    onPressed: () {
                                      Clipboard.setData(
                                        ClipboardData(
                                          text: selectedPost!.title,
                                        ),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Copied!'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                spacing: 1,
                                children: [
                                  Expanded(child: Text(selectedPost!.userId)),
                                  Expanded(child: Text(selectedPost!.datetime)),
                                ],
                              ),
                              SizedBox(height: 50),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      selectedPost!.body,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.copy),
                                    tooltip: 'Copy title',
                                    onPressed: () {
                                      Clipboard.setData(
                                        ClipboardData(text: selectedPost!.body),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Copied!'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Posts', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Row(
        children: isSwapped
            ? [detailPanel, listPanel]
            : [listPanel, detailPanel],
      ),
    );
  }
}