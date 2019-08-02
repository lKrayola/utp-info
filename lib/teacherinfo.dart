import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TeacherInfo extends StatefulWidget{
  dynamic data;
  TeacherInfo(this.data);
  @override

  State<StatefulWidget> createState(){
    return TeacherInfoState(this.data);
  }
}

class TeacherInfoState extends State<TeacherInfo>{
  dynamic data;
  TeacherInfoState(this.data);
  @override
  
  Widget build(BuildContext context)
  {
    return Scaffold(
    
      appBar: AppBar(
        title: Text(data['nombre']),
        backgroundColor: Colors.green[500],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Text(
              'Información General',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.green[300]
            ),
          ),
          Container(
            child: Text(
              'Cedula: '+data['cedula']+'\n'+'\n'
              +'Facultad: '+data['facultad']+'\n'+'\n'
              +'Correo electrónico: '+data['correo']+'\n'+'\n'
              +'Telefono: '+data['telefono']+'\n'+'\n'
              +'Oficina: '+data['oficina']+'\n',
              style: TextStyle(
                fontSize: 16
              ),
            ),
            padding: EdgeInsets.fromLTRB(26.0, 16.0, 16.0, 0.0),
          ),
          Container(
            child: Text(
              'Horario',
              style: TextStyle(
                fontSize: 22,
                decorationThickness: 200
              ),
            ),
            padding: EdgeInsets.fromLTRB(8.0, 8.0, 16.0, 8.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.green[300]
            ),
          ),
        ]
      ),
    );
  }
}