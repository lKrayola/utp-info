import 'package:flutter/material.dart';
import 'welcome.dart';
import 'state_widget.dart';
import 'state.dart';

class Home extends StatefulWidget {

  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home>{
  StateModel appState;
  
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

  Widget _buildHomeScreen({Widget body}) {
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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,         
                    children: <Widget>[          
                      new Container(
                        padding: EdgeInsets.all(20.0),
                        height: 150.0,
                        width: 150.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(appState.user.photoUrl.toString()),
                          ),
                        )),
                      
                      new Text(            
                        'Hello, ' '${appState.user.displayName}' '!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      )
                  ],
                )),
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

  Widget _buildContent() {
    if (appState.isLoading) {
      return _buildLoadingIndicator();
    } else if (!appState.isLoading && appState.user == null) {
      return new Welcome();
    } else {
      return _buildHomeScreen();
    }
  }

  Center _buildLoadingIndicator() {
    return Center(
      child: new CircularProgressIndicator(),
    );
  }
  @override
  Widget build(BuildContext context) {
    // Build the content depending on the state:
    appState = StateWidget.of(context).state;
    return _buildContent();
  }
}