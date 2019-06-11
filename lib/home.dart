import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home>{

  @override
  int _selectedIndex = 1;

  PageController controller = PageController(
    initialPage: 1,
  );

//Navigation bar signal to page changing, connected
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      controller.animateToPage(
        _selectedIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

//PageViewSwipe signal to nav bar focus change, connected
void _onPageChanged(int page){
  setState(() {
    _selectedIndex = page; 
  });
}

//Back button confirmation from home page
  Future<bool> _onBackPressed(){
    return showDialog(
      context: context,
      builder: (context)=> AlertDialog(
        title: Text("Desea salir de la aplicacion?"),
        actions: <Widget>[
          FlatButton(
            child: Text("No"),
            onPressed: ()=>Navigator.pop(context,false),

          ),
          FlatButton(
            child: Text("Sí"),
            onPressed: ()=>Navigator.pop(context,true)
          )
        ],
      )
    );
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Center( //Swiping Page Views
          child: PageView(
            controller: controller,
            onPageChanged: _onPageChanged,
            children: <Widget>[
              Container(
                color: Colors.green[400],
                child: Placeholder(
                  color: Colors.purpleAccent
                ),
              ),
              Container(
                color: Colors.green[300],
                child: Placeholder(
                  color: Colors.purpleAccent,
                ),
              ),
              Container(
                color: Colors.green[500],
                child: Placeholder(
                  color: Colors.purpleAccent,
                ),
              ),
            ],
          )
        ),//Nav Bar with 3 nav options
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Buscar'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Inicio'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Cuenta'),
            ),
          ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[900],
        onTap: _onItemTapped,
        ),
      )
    );
  }
}