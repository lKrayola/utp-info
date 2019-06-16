import 'package:flutter/material.dart';

//Simple template login screen with one button
class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

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
            TextField(
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
            ),
            SizedBox(height: 12.0),
            //                              Campo Contraseña
            TextField(
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
                  child: Text('Entrar'),
                  onPressed: (){
                    Navigator.pushNamed(context, '/Home');
                  }
                )
              ],
            )
          ],
        )
      )
    );
  }
}