import 'package:flutter/material.dart';
import 'package:x_french/pages/home_viewmodel.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
final HomeViewModel _homeViewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Posts'),
        backgroundColor: Color.fromARGB(255, 250, 250, 250),
      ),
      body:ListenableBuilder(
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
                     return Card(
                      color: const Color.fromARGB(255, 255, 255, 255),
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
                        );
                      },
                       ),
               );
        },
      )
    );
  }
}