import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text("UTP Info Demo Welcome"),
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
            Text("\t\t\t\t\t\tBienvenido a la Aplicacion de busqueda de horarios de \n\t\t\t\t\t\t\tdocentes UTP"),
            SizedBox(height: 40.0),
                RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  child: Text('Continuar'),
                  onPressed: (){
                    Navigator.pushNamed(context, '/Login');
                  }
                )
          ],
        )
      )
    );
  }
}