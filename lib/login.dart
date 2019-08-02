import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'state_widget.dart';
import 'auth.dart';
import 'home.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title, this.auth, this.onSignedIn}) : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  final String title;

  @override
  _LoginState createState() => _LoginState();
}

enum FormMode { LOGIN, SIGNUP }

class _LoginState extends State<Login> {

  final _formKey = new GlobalKey<FormState>();


  String _email;
  String _password;
  String _errorMessage;

  // Initial form is login form
  FormMode _formMode = FormMode.LOGIN;
  bool _isIos;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (_validateAndSave()) {
      String userId = "";
      try {
        if (_formMode == FormMode.LOGIN) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
          Navigator.pushNamed(context, '/Home');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          widget.auth.sendEmailVerification();
          _showVerifyEmailSentDialog();
          print('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId != null && userId.length > 0 && _formMode == FormMode.LOGIN) {
          widget.onSignedIn();
        }

      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          if (_isIos) {
            _errorMessage = e.details;
          } else
            _errorMessage = e.message;
        });
      }
    }
  }

  @override

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  void _changeFormToSignUp() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  void _changeFormToLogin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }

  @override


  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text("UTP Info Demo Login"),
        backgroundColor: Colors.green[900],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[

            new Form(
              key: _formKey,
              child: new ListView(
                shrinkWrap: true,
                children: <Widget>[
                  _showErrorMessage(),
                  _showCircularProgress(),
                  SizedBox(height: 80.0),
                  Column(
                    children: <Widget>[
                    //Icon(Icons.)
                    SizedBox(height:20.0),
                    //Text('Login'),
                    ]
                  ,),
                  SizedBox(height: 100.0),
                  //                              Campo Correo
                  TextFormField(
                    cursorColor: Colors.green,
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: 'Correo electronico',
                      hintText: 'Ejemplo: chichero@utp.ac.pa',
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          _isLoading = false;
                        });
                        return 'Email can\'t be empty';
                      }
                    },
                    onSaved: (value) => _email = value
                  ),
                  SizedBox(height: 12.0),
                  //                              Campo Contraseña
                  TextFormField(
                    cursorColor: Colors.green,
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: InputBorder.none,
                      //hintText: 'Contraseña',
                      filled: true,
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          _isLoading = false;
                        });
                        return 'Email can\'t be empty';
                      }
                    },
                    onSaved: (value) => _password = value
                  ),
                  ButtonBar(
                    children: <Widget>[
                      //                              Boton Registrarse
                      FlatButton(
                        child: Text('Registrarse'),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        onPressed: (){
                          Navigator.pushNamed(context, '/Register');
                        },
                      ),
                      //                              Boton Entrar
                      RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        child: _formMode == FormMode.LOGIN
                          ? new Text('Login',
                            style: new TextStyle(fontSize: 20.0, color: Colors.white))
                          : new Text('Create account',
                            style: new TextStyle(fontSize: 20.0, color: Colors.white)),
                        onPressed: () {
                          _changeFormToLogin();
                          _validateAndSubmit();
                          Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (BuildContext context) => Home()));
                        } 
                      )
                    ],
                  ),
                  //                                  Boton Entrar con Google
                  RaisedButton(
                    onPressed: () => StateWidget.of(context).signInWithGoogle(),
                    padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 3.0),
                    color: const Color(0xFFFFFFFF),
                    child: new Row( 
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        //new Image.asset(
                        //  'asset/google_button.jpg',
                        //  height: 40.0,
                        //),
                        new Container(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            child: new Text( 
                              "Sign in with Google",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            )
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            
          ],
        )
      )
    );
  }

  Widget _showCircularProgress(){
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } return Container(height: 0.0, width: 0.0,);

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
                _changeFormToLogin();
                Navigator.of(context).pop();
                
              },
            ),
          ],
        );
      },
    );
  }

  Widget _showErrorMessage() {
    if (_errorMessage != null && _errorMessage.length > 0) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }
}