import 'package:flutter/material.dart';

void main() {
  runApp( MaterialApp(
    home: Home(),
  ));
}


class Home extends StatefulWidget {


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> _screens=[

  Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      alignment: Alignment.center,
      child: Text('Home',style: TextStyle(fontSize: 40),),
    ),
 Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      alignment: Alignment.center,
      child: Text('Travel',style: TextStyle(fontSize: 40),),
    ), 
    Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      alignment: Alignment.center,
      child: Text('Account',style: TextStyle(fontSize: 40),),
    ),

  ];
  int _selectedIndex =0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('site'),
      ),
        body:Row(
          children: [
            if (MediaQuery.of(context).size.width >=640 )
      NavigationRail(
         indicatorColor: const Color.fromARGB(255, 186, 186, 186),
        backgroundColor: Colors.white,
        onDestinationSelected: (int index) {
         setState(() {
            _selectedIndex=index;
         });
        },
        selectedIndex: _selectedIndex,
        destinations: const [
          NavigationRailDestination(
            icon: Icon(Icons.home), label: Text('Home')
            ),
             NavigationRailDestination(
            icon: Icon(Icons.travel_explore_outlined), label: Text('Travel')
            ),
             NavigationRailDestination(
            icon: Icon(Icons.account_circle_outlined), label: Text('Account')
            ),
        ],
        labelType: NavigationRailLabelType. all,
selectedLabelTextStyle: const TextStyle(
color: Color.fromARGB(255, 0, 0, 0),
), // TextStyle

unselectedLabelTextStyle: const TextStyle(color: Color.fromARGB(255, 72, 72, 72)),
// Called when one tab is selected
leading: Column(
children: [
  Image.asset('assets/logo.png',width: 100,),
SizedBox(
height: 4,
),
],
),  
  ),
    Expanded(child: _screens[_selectedIndex])
          ],
        ) ,
      bottomNavigationBar:MediaQuery.of(context).size.width <640? BottomNavigationBar(
        currentIndex: _selectedIndex,
        unselectedItemColor: const Color.fromARGB(255, 72, 72, 72),
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        
        //called when one tab is selected
       onTap: (int index) {
            setState(() {
           _selectedIndex = index;
       });
    },
    backgroundColor: Colors.white,
        //bottom tab items
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.home), label: 'Home'
          ),
            BottomNavigationBarItem(
            icon: Icon(Icons.travel_explore_outlined), label: 'Travel'
          ),
            BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined), label: 'Account'
          )
        ],
      ):null,

    );
  }
}

