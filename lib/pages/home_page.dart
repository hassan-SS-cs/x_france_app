import 'package:flutter/material.dart';
import 'package:x_french/models/post.dart';
import 'package:x_french/services/api_service.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  late List<Post> data =[];

late Future<List<Post>> _postsFuture;

@override
void initState() {
  super.initState();
  _postsFuture = apiService.getPost(); 
}
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Posts'),
        backgroundColor: Color.fromARGB(255, 250, 250, 250),
      ),
      body: FutureBuilder<List<Post>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }if(snapshot.hasError){ 
            return Text('error');
           }
             return  Container(
              color: const Color.fromARGB(255, 250, 250, 250),
               child: MasonryGridView.builder(
                      gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                 ),
                 itemCount: snapshot.data!.length,
                 itemBuilder: (context, i) {
                   return Card(
                    color: const Color.fromARGB(255, 255, 255, 255),
                     child: Padding(
                       padding: EdgeInsets.all(15),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(snapshot.data![i].title,
                  style: TextStyle(fontWeight: FontWeight.bold)),
                           SizedBox(height: 10),
                           Text(snapshot.data![i].body),
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