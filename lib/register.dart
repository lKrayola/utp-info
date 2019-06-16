import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text("UTP Info Demo Register"),
        backgroundColor: Colors.green[900],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            Column(
              children: <Widget>[
              //Icon(Icons.)
              SizedBox(height:20.0),
              //Text('Login'),
              ]
            ,),
            SizedBox(height: 70.0),
            TextField(
              cursorColor: Colors.green,
              autofocus: false,
              decoration: InputDecoration(
                labelText: 'Nombre Completo',
                hintText: 'Ejemplo: Chicharito Lopez',
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: InputBorder.none,
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              cursorColor: Colors.green,
              autofocus: false,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: InputBorder.none,
                filled: true,
              ),
              obscureText: true,
            ),
            SizedBox(height: 12.0),
            TextField(
              cursorColor: Colors.green,
              autofocus: false,
              decoration: InputDecoration(
                labelText: 'Facultad',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: InputBorder.none,
                hintText: 'Ejemplo: FISC',
                filled: true,
              ),
              obscureText: false,
            ),
            SizedBox(height: 12.0),
            TextField(
              cursorColor: Colors.green,
              autofocus: false,
              decoration: InputDecoration(
                labelText: 'Carrera',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: InputBorder.none,
                hintText: 'Ejemplo: Ing. En Chichero',
                filled: true,
              ),
              obscureText: false,
            ),
            SizedBox(height: 12.0),
            TextField(
              cursorColor: Colors.green,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              decoration: InputDecoration(
                labelText: 'Correo electronico',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: InputBorder.none,
                hintText: 'Ejemplo: chichero@utp.ac.pa',
                filled: true,
              ),
              obscureText: false,
            ),
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  child: Text('Cancelar'),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  onPressed: (){
                    Navigator.pop(context, true);
                  },
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  child: Text('Registrarse'),
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