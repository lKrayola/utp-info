import 'package:flutter/material.dart';
import 'welcome.dart';
import 'state_widget.dart';
import 'state.dart';
import 'dart:async';
import 'auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Home extends StatefulWidget {

  Home({Key key, this.auth, this.userId, this.onSignedOut, this.title}) : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  final String title;

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home>{

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isEmailVerified = false;

  @override

  void initState() {
    super.initState();

    _checkEmailVerification();
  }

  void _checkEmailVerification() async {
    _isEmailVerified = await widget.auth.isEmailVerified();
    if (!_isEmailVerified) {
      _showVerifyEmailDialog();
    }
  }

  void _resentVerifyEmail(){
    widget.auth.sendEmailVerification();
    _showVerifyEmailSentDialog();
  }

  void _showVerifyEmailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text("Please verify account in the link sent to email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Resent link"),
              onPressed: () {
                Navigator.of(context).pop();
                _resentVerifyEmail();
              },
            ),
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text("Link to verify account has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }


  
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
                      ),
                      new FlatButton(
                        child: new Text('Logout',
                          style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                          onPressed: () {
                            _signOut();
                            Navigator.pop(context, true);
                          }
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